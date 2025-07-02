package org.sample.domain;
import lombok.Data;

@Data
public class MyPagePostDTO {
    private Long boardid;
    private String title;
    private String nickname;
    private String product;
    private int price;
    private String brand;
    private String condition;
    private String status;
    private String regdate;
    private String imgPath;
}