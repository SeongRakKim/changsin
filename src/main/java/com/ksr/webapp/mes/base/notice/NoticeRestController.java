package com.ksr.webapp.mes.base.notice;

import com.ksr.webapp.common.vo.VMap;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@Transactional
@RequiredArgsConstructor
public class NoticeRestController {

    private final NoticeQueryRepository noticeQueryRepository;

    @PostMapping("/mes/base/notice/noticeList")
    public ResponseEntity<List<Notice>> noticeList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Notice> noticeList = noticeQueryRepository.noticeList(vmap);

        return new ResponseEntity<>(noticeList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/notice/noticeOne/{notice_cd}")
    public ResponseEntity<Notice> noticeOne(VMap vmap, @PathVariable("notice_cd") String notice_cd) throws Exception
    {
        vmap.put("notice_cd", notice_cd);
        Notice noticeOne = noticeQueryRepository.noticeOne(vmap);

        return new ResponseEntity<>(noticeOne, HttpStatus.OK);
    }

    @PostMapping("/mes/base/notice/noticeRegistModify")
    public ResponseEntity<String> noticeRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        noticeQueryRepository.noticeRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/notice/noticeDelete")
    public ResponseEntity<String> noticeDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        noticeQueryRepository.noticeDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/notice/noticePackDelete")
    public ResponseEntity<String> noticePackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        noticeQueryRepository.noticePackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
