package com.ysis.webapp.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
//@MapperScan(value = {"com.changsin.webapp.common.config"})
@EnableTransactionManagement
public class MybatisConfig {

//    @Bean
//    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
//        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
//        sqlSessionFactoryBean.setDataSource(dataSource);
//        return sqlSessionFactoryBean.getObject();
//    }
//
//    @Bean
//    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) throws Exception {
//        return new SqlSessionTemplate(sqlSessionFactory);
//    }

}
