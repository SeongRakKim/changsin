package com.ksr.webapp.mes.base.department;

import com.ksr.webapp.common.vo.VMap;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@RequiredArgsConstructor
@Repository
public class DepartmentQueryRepository {

    private final JPAQueryFactory queryFactory;
    private final QDepartment qDepartment = QDepartment.department;
    private final DepartmentRepository departmentRepository;

    public List<Department> findAll() {
        return queryFactory.selectFrom(qDepartment)
                    .fetch();
    }

//    public Department saveDepartment(VMap vmap) {
//
//        Department department = Department
//                .builder()
//                .dept_nm()
//
//        return departmentRepository.save();
//    }


}
