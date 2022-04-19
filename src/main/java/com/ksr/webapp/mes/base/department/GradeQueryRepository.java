package com.ksr.webapp.mes.base.department;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Repository
public class GradeQueryRepository {

    private final JPAQueryFactory queryFactory;
    private final QGrade qGrade;
    private final GradeRepository gradeRepository;
    private final EntityManager em;

    @Transactional
    public List<Grade> gradeList(VMap vmap) {
        return queryFactory.selectFrom(qGrade)
                    .fetch();
    }

    @Transactional
    public void gradeRegistModify(VMap vmap) {

        List<String> grade_cd =  (List<String>)vmap.get("ary_grade_cd");
        List<String> grade_nm =  (List<String>)vmap.get("ary_grade_nm");

        List<Grade> registList = new ArrayList<>();

        for(int i=0; i<grade_cd.size(); i++)
        {
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
            String nowString = now.format(dateTimeFormatter);

            registList.add(new Grade(grade_cd.get(i)
                                            ,grade_nm.get(i)
                                            ,CommonUtils.isEmpty(vmap.getString("u_cd")) ? "admin" : vmap.getString("u_cd")
                                            ,CommonUtils.isEmpty(vmap.getString("u_cd")) ? "admin" : vmap.getString("u_cd")
                                            ,nowString
                                            ,nowString
                                          ));
        }

        gradeRepository.saveAll(registList);
    }

    @Transactional
    public void gradeDelete(VMap vmap) {

        queryFactory.delete(qGrade)
                .where(qGrade.grade_cd.eq(vmap.getString("grade_cd")))
                .execute();

    }


}
