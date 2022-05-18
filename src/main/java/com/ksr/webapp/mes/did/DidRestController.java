package com.ksr.webapp.mes.did;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.equipment.EquipmentService;
import com.ksr.webapp.mes.base.notice.Notice;
import com.ksr.webapp.mes.base.notice.NoticeQueryRepository;
import com.ksr.webapp.mes.production.result.ProductionResultService;
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
public class DidRestController {

    private final NoticeQueryRepository noticeQueryRepository;
    private final ProductionResultService productionResultService;
    private final EquipmentService equipmentService;

    @PostMapping("/did/notice/noticeSize")
    public ResponseEntity<Integer> noticeSize(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Notice> noticeList = noticeQueryRepository.noticeList(vmap);

        return new ResponseEntity<>(noticeList.size(), HttpStatus.OK);
    }

    @PostMapping("/did/notice/noticeList")
    public ResponseEntity<Notice> noticeList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        Notice notice = noticeQueryRepository.noticeOne2(vmap);

        return new ResponseEntity<>(notice, HttpStatus.OK);
    }

    @PostMapping("/did/production/planResultDidList")
    public ResponseEntity<List<Map<String, Object>>> planResultDidList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = productionResultService.planResultDidList(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @PostMapping("/did/equipment/equipmentInterfaceData")
    public ResponseEntity<List<Map<String, Object>>> equipmentInterfaceData(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = equipmentService.equipmentInterfaceData(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

}
