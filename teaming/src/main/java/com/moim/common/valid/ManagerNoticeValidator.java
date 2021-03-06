package com.moim.common.valid;


import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.moim.vo.ManagerNoticeVO;


public class ManagerNoticeValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		
		return ManagerNoticeVO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object object, Errors errors) {
		ManagerNoticeVO managerNotice = (ManagerNoticeVO) object;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mNoticeTitle", "required","제목을 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mNoticeContent", "required", "내용을 입력해주세요.");

		// 만약 내용이 지나치게 짧으면 
		if(managerNotice.getmNoticeContent().length() == 0 ||managerNotice.getmNoticeContent().length() <6) {
			errors.rejectValue("mNoticeContent", "lengthsize", "내용이 너무 짧습니다.");
		}
		
	}


}
