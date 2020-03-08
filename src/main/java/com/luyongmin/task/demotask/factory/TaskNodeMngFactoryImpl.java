package com.luyongmin.task.demotask.factory;

import com.luyongmin.task.demotask.domain.TaskNode;
import com.luyongmin.task.demotask.enums.TaskNodeCode;
import com.luyongmin.task.demotask.service.TaskNodeMngInf;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 17:51
 * @description:
 */
@Component
public class TaskNodeMngFactoryImpl implements TaskNodeMngFactory {

    private Map<String, TaskNodeMngInf> mngMap;

    /**
     * 通过授权获取对应的策略
     * @param taskNode
     * @return
     */
    @Override
    public TaskNodeMngInf getManager(TaskNode taskNode) {

        TaskNodeCode nodeCode = TaskNodeCode.getByCode(taskNode.getNodeCode());

        if(nodeCode != null){
            return mngMap.get(nodeCode.getCode());
        }
        return null;
    }

    public void setMngMap(Map<String, TaskNodeMngInf> mngMap) {
        this.mngMap = mngMap;
    }
}
