package com.luyongmin.task.demotask.service.impl;

import com.luyongmin.task.demotask.domain.TaskNodeTemplate;
import com.luyongmin.task.demotask.domain.TaskTemplate;
import com.luyongmin.task.demotask.mapper.TaskNodeTemplateMapper;
import com.luyongmin.task.demotask.mapper.TaskTemplateMapper;
import com.luyongmin.task.demotask.service.TaskTemplateService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:20
 * @description:
 */
@Service
public class TaskTemplateServiceImpl implements TaskTemplateService {

    private static final Logger logger = LoggerFactory.getLogger(TaskTemplateServiceImpl.class);

    @Autowired
    private TaskTemplateMapper taskTemplateMapper;

    @Autowired
    private TaskNodeTemplateMapper taskNodeTemplateMapper;

//    @Autowired
//    protected Gson gson;

    /**
     * 根据任务编号查询任务模板
     * @param taskCode
     * @return
     */
    @Override
    public TaskTemplate queryCacheByCode(String taskCode){

        Map<String,TaskTemplate> taskTemplateCache = getCache();

        TaskTemplate template = taskTemplateCache.get(taskCode);

        if(template != null){
            return template;
        }

        template = queryByCode(taskCode);

        taskTemplateCache.put(taskCode, template);
       // RedisPool.getInstance().set(Constant.CACHE_KEY_TASK_TEMPLATE, Constant.CACHE_24h_SECONDS, gson.toJson(taskTemplateCache));

        return template;
    }

    public TaskTemplate queryByCode(String taskCode){
        TaskTemplate template = taskTemplateMapper.queryByCode(taskCode);

        if(template != null){
            List<TaskNodeTemplate> nodeTemplateList = taskNodeTemplateMapper.queryByTaskCode(taskCode);
            template.setNodeTemplateList(nodeTemplateList);
        }

        return template;

    }

    /**
     * 从缓存中获取所有模板
     * @return
     */
    private Map<String, TaskTemplate> getCache() {
        Map<String, TaskTemplate> cacheMap = null;
                //gson.fromJson(RedisPool.getInstance().get(Constant.CACHE_KEY_TASK_TEMPLATE), new TypeToken<Map<String, TaskTemplate>>() {}.getType());;

        if(cacheMap == null){
            cacheMap = new HashMap<String, TaskTemplate>();
        }

        return cacheMap;
    }
}
