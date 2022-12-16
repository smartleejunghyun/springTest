package kr.smhrd.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.smhrd.mapper.TimeMapper;
import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class TimeMapperTests {

	@Setter(onMethod_=@Autowired)
	private TimeMapper timeMapper;
	
	@Test
	public void testGetTime() {
		System.out.print(timeMapper.getClass().getName());
		System.out.print(timeMapper.getTime());
	}
	
	@Test
	public void testGetTime2() {
		System.out.println("getTime2");
		System.out.println(timeMapper.getTime2());
	}
	
	
}
