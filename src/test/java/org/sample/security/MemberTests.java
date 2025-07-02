package org.sample.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class MemberTests {

    @Autowired
    private PasswordEncoder pwencoder;

    @Autowired
    private DataSource ds;

    @Test
    public void testUpdatePassword() {
        String sql = "UPDATE pd_user SET pwd = ? WHERE nickname = ?";

        // 예시 사용자들 (미리 등록된 nickname 기준)
        String[] nicknames = { "user149", "admin01", "testuser" };

        for (String nickname : nicknames) {
            try (Connection conn = ds.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

                String rawPassword = "1234"; // 기존 평문 비밀번호
                String encPassword = pwencoder.encode(rawPassword);

                pstmt.setString(1, encPassword);
                pstmt.setString(2, nickname);

                int updated = pstmt.executeUpdate();
                log.info(nickname + " 비밀번호 업데이트 결과: " + updated);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Test
    public void validatePassword() {
        // DB에 저장된 암호화된 비밀번호 (예시)
        String encoded = "$2a$10$ovyC.N5N6UZeYCeeW4FVb.irt4qLIBJkCRa9iYheK27AAnyg4TspG";

        if (pwencoder.matches("1234", encoded)) {
            log.info("비밀번호 일치");
        } else {
            log.info("비밀번호 불일치");
        }
    }
    @Test
    public void testEncryptAll1234Users() {
        String selectSql = "SELECT nickname FROM pd_user WHERE pwd = '1234'";
        String updateSql = "UPDATE pd_user SET pwd = ? WHERE nickname = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement selectStmt = conn.prepareStatement(selectSql);
             PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {

            var rs = selectStmt.executeQuery();

            while (rs.next()) {
                String nickname = rs.getString("nickname");
                String encodedPwd = pwencoder.encode("1234");

                updateStmt.setString(1, encodedPwd);
                updateStmt.setString(2, nickname);

                int result = updateStmt.executeUpdate();
                log.info("[" + nickname + "] → 암호화 완료: " + result + "행 수정");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
