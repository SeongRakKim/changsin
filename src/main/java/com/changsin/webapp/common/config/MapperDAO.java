package com.changsin.webapp.common.config;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

public class MapperDAO {

    private static final Logger logger = LoggerFactory.getLogger(MapperDAO.class);

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    protected void mapperId(String mapperId) {
        logger.info("mapperId : ==============     " + mapperId + "     =================");
    }

    public List<Map<String, Object>> selectList(String selectId, Object parameter) {
        mapperId(selectId);
        return sqlSessionTemplate.selectList(selectId, parameter);
    }
}
