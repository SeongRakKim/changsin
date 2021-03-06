package com.ksr.webapp.mes.base.department;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Repository
public class DepartmentQueryRepository {

    private final JPAQueryFactory queryFactory;
    private final QDepartment qDepartment = QDepartment.department;
    private final DepartmentRepository departmentRepository;
    private final EntityManager em;

    @Transactional
    public List<Department> deptList(VMap vmap) {
        return queryFactory.selectFrom(qDepartment)
                    .fetch();
    }

    @Transactional
    public void deptRegistModify(VMap vmap) {

        List<String> dept_cd =  (List<String>)vmap.get("ary_dept_cd");
        List<String> dept_nm =  (List<String>)vmap.get("ary_dept_nm");

        List<Department> registList = new ArrayList<>();

        for(int i=0; i<dept_cd.size(); i++)
        {
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
            String nowString = now.format(dateTimeFormatter);

            registList.add(new Department(dept_cd.get(i)
                                            ,dept_nm.get(i)
                                            ,CommonUtils.isEmpty(vmap.getString("u_cd")) ? "admin" : vmap.getString("u_cd")
                                            ,CommonUtils.isEmpty(vmap.getString("u_cd")) ? "admin" : vmap.getString("u_cd")
                                            ,nowString
                                            ,nowString
                                          ));
        }

        departmentRepository.saveAll(registList);
    }

    @Transactional
    public void deptDelete(VMap vmap) {

        queryFactory.delete(qDepartment)
                .where(qDepartment.dept_cd.eq(vmap.getString("dept_cd")))
                .execute();

    }


}
