package com.ysis.webapp.common.config;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

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

    public String selectOneString(String selectId, Object parameter) {
        mapperId(selectId);
        return sqlSessionTemplate.selectOne(selectId, parameter);
    }

    public Map<String, Object> selectOne(String selectId, Object parameter) {
        mapperId(selectId);
        return sqlSessionTemplate.selectOne(selectId, parameter);
    }

    public int insert(String selectId, Object parameter) {
        mapperId(selectId);
        return sqlSessionTemplate.insert(selectId, parameter);
    }

    public int update(String selectId, Object parameter) {
        mapperId(selectId);
        return sqlSessionTemplate.update(selectId, parameter);
    }

    public int delete(String selectId, Object parameter) {
        mapperId(selectId);
        return sqlSessionTemplate.delete(selectId, parameter);
    }
}
