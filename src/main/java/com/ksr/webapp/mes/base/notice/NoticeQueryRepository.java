package com.ksr.webapp.mes.base.notice;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.notice.Notice;
import com.ksr.webapp.mes.base.notice.NoticeRepository;
import com.ksr.webapp.mes.base.notice.QNotice;
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
public class NoticeQueryRepository {

    private final JPAQueryFactory queryFactory;
    private final QNotice qNotice = QNotice.notice;
    private final NoticeRepository noticeRepository;
    private final EntityManager em;

    @Transactional
    public List<Notice> noticeList(VMap vmap) {
        return queryFactory.selectFrom(qNotice)
                    .orderBy(qNotice.notice_stdt.asc())
                    .fetch();
    }

    @Transactional
    public Notice noticeOne2(VMap vmap) {
        return queryFactory.selectFrom(qNotice)
                .orderBy(qNotice.notice_stdt.asc())
                .limit(1)
                .offset(vmap.getLong("offset"))
                .fetchOne();
    }

    @Transactional
    public Notice noticeOne(VMap vmap) {
        return queryFactory.selectFrom(qNotice)
                    .where(qNotice.notice_cd.eq(vmap.getString("notice_cd")))
                    .fetchOne();
    }

    @Transactional
    public void noticeRegistModify(VMap vmap) {

        List<Notice> registList = new ArrayList<>();

        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
        String nowString = now.format(dateTimeFormatter);

        registList.add(new Notice(vmap.getString("notice_cd"),
                    vmap.getString("notice_title"),
                    vmap.getString("notice_content"),
                    vmap.getString("notice_stdt"),
                    vmap.getString("notice_eddt"),
                    nowString,
                    vmap.getString("u_cd"),
                    nowString,
                    vmap.getString("u_cd")
                )
        );

        noticeRepository.saveAll(registList);
    }


    @Transactional
    public void noticeDelete(VMap vmap) {

        queryFactory.delete(qNotice)
                .where(qNotice.notice_cd.eq(vmap.getString("notice_cd")))
                .execute();

    }

    @Transactional
    public void noticePackDelete(VMap vmap) {

        List<String> deleteItems =  (List<String>)vmap.get("deleteItems");

        for(int i=0; i<deleteItems.size(); i++)
        {
            queryFactory.delete(qNotice)
                    .where(qNotice.notice_cd.eq(deleteItems.get(i)))
                    .execute();
        }

    }

}
