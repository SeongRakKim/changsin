package com.ksr.webapp.mes.base.user;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.department.DepartmentQueryRepository;
import com.ksr.webapp.mes.base.grade.GradeQueryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final DepartmentQueryRepository departmentQueryRepository;
    private final GradeQueryRepository gradeQueryRepository;

    @GetMapping("/mes/base/user/list")
    public void companyList(VMap vmap, Model model, HttpServletRequest httpServletRequest) throws Exception {
        vmap.put("requestUri", httpServletRequest.getRequestURI());

        vmap.put("deptList", departmentQueryRepository.deptList(vmap));
        vmap.put("gradeList", gradeQueryRepository.gradeList(vmap));
    }


}
