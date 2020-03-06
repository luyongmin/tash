package com.luyongmin.task.demotask.config;

import com.alibaba.druid.pool.DruidDataSource;
import org.apache.ibatis.io.VFS;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.mybatis.spring.boot.autoconfigure.SpringBootVFS;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;
import java.util.Properties;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 14:54
 * @description:
 */
@Configuration
@MapperScan(basePackages = {"com.luyongmin.task.demotask.mapper"}, sqlSessionTemplateRef = "sqlSessionAccountTemplate")
public class SettleDataSourceConfig {


    @Bean(name = "settleDataSource")
    @ConfigurationProperties(prefix="settledb")
    public DataSource dataSource() {
        return new DruidDataSource();
    }

    @Bean
    public PlatformTransactionManager transactionManager() {
        return new DataSourceTransactionManager(dataSource());
    }

    @Bean("settleSqlSessionFactory")
    public SqlSessionFactory sqlSessionFactory(@Qualifier("settleDataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);
        VFS.addImplClass(SpringBootVFS.class);
        ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        sessionFactory.setMapperLocations(resolver.getResources("classpath*:sql/settle/*.xml"));

        //分页插件
        Properties properties = new Properties();
        properties.setProperty("helperDialect", "mysql");
        properties.setProperty("offsetAsPageNum", "true");
        properties.setProperty("rowBoundsWithCount", "true");
        properties.setProperty("reasonable", "true");
//        Interceptor interceptor = new PageInterceptor();
//        interceptor.setProperties(properties);
//        sessionFactory.setPlugins(new Interceptor[] {interceptor});
        return sessionFactory.getObject();
    }

    @Bean
    public SqlSessionTemplate sqlSessionAccountTemplate(@Qualifier("settleSqlSessionFactory") SqlSessionFactory sqlSessionFactory) {
        return new SqlSessionTemplate(sqlSessionFactory);
    }
}
