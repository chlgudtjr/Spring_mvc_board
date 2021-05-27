package edu.bit.ex.board.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class MemberDetails implements UserDetails {

	private static final long serialVersionUID = 1L;

	private String username;
	private String password;
	private List<GrantedAuthority> authorities;

	// setter
	public void setUsername(String username) {
		this.username = username;
	}

	// setter
	public void setPassword(String password) {
		this.password = password;
	}

	// setter
	public void setAuthorities(List<String> authList) {

		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

		if (this.username.equals("admin")) {
			authorities.add(new SimpleGrantedAuthority("ADMIN"));
		} else {
			authorities.add(new SimpleGrantedAuthority("MEMBER"));
		}

		this.authorities = authorities;
	}

	@Override
	public String getUsername() {
		// ID - ID정보의 필드에 대한 getter, security에서는 ID를 'username'이라고 표현
		return username;
	}

	@Override
	public String getPassword() {
		// PW -PW정보의 필드에 대한 getter, security에서는 PW를 'password'이라고 표현
		return password;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// 권한
		/*
		 * 권한은 'GrantedAuthority' 인터페이스를 구현한 'SimleGrantedAuthority' 클래스에 하나씩 담아주면 됩니다. 한 객체 당 하나의 권한이며, 컬렉션 계열에 모두 담아주면 됩니다. 한 사람이 여러 권한을 가질 수 있기 때문에
		 * 복수의 데이터를 담을 수 있도록 되어 있고, 이름은 복잡하지만 실질적으로 우리는 그냥 String 타입의 권한명만 객체에 담아주면 되는지라 매우 간단한 구조입니다. List<String> 타입으로 권한 데이터를 받아서 해당 타입으로 변환해주는
		 * setter를 만들어서 주입해줬습니다. 스프링 Security에서 고정된 권한 리스트 타입이기 때문에 그대로 구현해줘야 합니다.
		 */
		return authorities;
	}

	@Override
	public boolean isAccountNonExpired() {
		// 계정이 만료 되지 않았는가?
		// DB에 만료여부에 대한 컬럼을 따로 만들어두고 판별해서 만료된 계정이라면 false, 만료되지 않았다면 true를 반환하면 됩니다.
		// "만료되지 않았는지(Non) 여부" 이기 때문에 true를 반환해야 사용가능한 계정이라는 뜻입니다.
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// 계정이 잠기지 않았는가?
		// 만료가 아니라 잠김입니다. 만료는 유효기간이 다 됐다는 뜻이고 잠김은 좀 더 여러가지 이유로 인해 사용 불가 처리된 것이라 생각하면 될 것 같습니다.
		// '않았는가'로 묻는 메소드이기 때문에 역시 true가 정상을 의미합니다.
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// 패스워드가 만료되지 않았는가?
		// 계정 자체는 살아있으나 패스워드가 만료된 경우이며, 이 경우 패스워드 변경 화면을 띄워준다거나 하는 로직으로 대응하면 됩니다.
		// Credential은 패스워드를 의미합니다. 역시 true가 정상을 의미합니다.
		return true;
	}

	@Override
	public boolean isEnabled() {
		// 계정이 활성화 되었는가?
		return true;
	}

}
