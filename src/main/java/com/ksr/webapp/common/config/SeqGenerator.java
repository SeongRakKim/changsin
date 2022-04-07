package com.ksr.webapp.common.config;

import org.hibernate.MappingException;
import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.id.IdentifierGenerator;
import org.hibernate.internal.util.config.ConfigurationHelper;
import org.hibernate.procedure.ProcedureCall;
import org.hibernate.procedure.ProcedureOutputs;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.spi.Configurable;
import org.springframework.data.jpa.repository.query.Procedure;

import javax.persistence.ParameterMode;
import java.io.Serializable;
import java.lang.reflect.Type;
import java.util.Map;
import java.util.Properties;

public class SeqGenerator implements IdentifierGenerator, Configurable {

    public static final String SEQ_GENERATOR_PARAM_KEY = "procedureParam";
    public String procedureParam;

    @Override
    public Serializable generate(SharedSessionContractImplementor session, Object object) {

        ProcedureCall procedureCall = session.createStoredProcedureCall("CREATE_NEX_SEQ_CODE"); // 호출할 프로시저

        procedureCall.registerParameter("NAME", String.class, ParameterMode.IN); // 입력받는 변수명
        procedureCall.registerParameter("PRIMARY_KEY", String.class, ParameterMode.OUT); // 반환변수명

        procedureCall.setParameter("NAME", procedureParam);

        ProcedureOutputs procedureOutputs = procedureCall.getOutputs();

        return (String) procedureOutputs.getOutputParameterValue("PRIMARY_KEY");
    }

    @Override
    public void configure(Map map) {

    }

    @Override
    public void configure(org.hibernate.type.Type type, Properties params, ServiceRegistry serviceRegistry)  throws MappingException{
        this.procedureParam = ConfigurationHelper.getString(SEQ_GENERATOR_PARAM_KEY, params);
    }

}
