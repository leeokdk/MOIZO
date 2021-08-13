package com.moim.service.impl;

import java.util.Random;

import javax.inject.Inject;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

@Service
public class MailSendService {
	@Inject
	private JavaMailSenderImpl mailSender;

	// 인증키 생성
	private String getKey(int size) {
		// size만큼 random 함수 생성 (여기선 6)
		Random random = new Random();
		StringBuffer buffer = new StringBuffer();
		int num = 0;

		while (buffer.length() < size) {
			num = random.nextInt(10);
			buffer.append(num);
		}

		return buffer.toString();
	}

	// 인증메일 보내기
	public String sendAuthMail(String email) {
		// 6자리 난수 인증번호 생성
		String authKey = getKey(6);

		// 인증메일 보내기

		MimeMessage mail = mailSender.createMimeMessage();
		String mailContent = "인증번호:   " + authKey; // 보낼 메시지
		try {
			mail.setSubject("회원가입 이메일 인증 ", "utf-8"); // 이메일 제목
			mail.setText(mailContent, "utf-8", "html"); // 보낼 메시지
			mail.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}

		return authKey;
	}
}
