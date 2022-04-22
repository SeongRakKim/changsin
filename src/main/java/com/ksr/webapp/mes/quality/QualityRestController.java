package com.ksr.webapp.mes.quality;

import com.ksr.webapp.common.vo.VMap;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@Transactional
@RequiredArgsConstructor
public class QualityRestController {

    private final QualityQueryRepository qualityQueryRepository;

    @PostMapping("/mes/quality/material/materialInspectList")
    public ResponseEntity<List<PurchaseQualityData>> materialInspectList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<PurchaseQualityData> purchasesList = qualityQueryRepository.materialInspectList(vmap);

        return new ResponseEntity<>(purchasesList, HttpStatus.OK);
    }

//    @PostMapping("/mes/base/grade/gradeRegistModify")
//    public ResponseEntity<String> gradeRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
//    {
//        vmap.set(map);
//        gradeQueryRepository.gradeRegistModify(vmap);
//
//        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
//    }
//
//    @DeleteMapping("/mes/base/grade/gradeDelete")
//    public ResponseEntity<String> gradeDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
//    {
//        vmap.set(map);
//        gradeQueryRepository.gradeDelete(vmap);
//
//        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
//    }

}
