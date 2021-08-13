package com.moim.common.valid;


import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.moim.vo.MoimScheduleVO;


public class MoimScheduleValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		
		return MoimScheduleVO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object object, Errors errors) {
		MoimScheduleVO moimSchedule = (MoimScheduleVO) object;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mScheduleModDate", "required","일정 날짜를 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mScheduleStartTime", "required", "시작 시간을 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mScheduleEndTime", "required", "종료 시간을 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mScheduleEnterMax", "required", "참여인원을 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mSchedulePlace", "required", "장소를 입력해주세요.");

		// 만약 참여인원이 2명 미만이면
		if(moimSchedule.getmScheduleEnterMax() < 3) {
			errors.rejectValue("mScheduleEnterMax", "MinimumPeople", "참여인원은 2명 미만일 수 없습니다.");
		}
		
	}


}
