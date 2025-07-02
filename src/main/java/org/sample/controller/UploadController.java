package org.sample.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UploadController {

    // 게시글 등록 시 파일 업로드 처리
    @PostMapping("/post/upload")
    public String uploadFiles(@RequestParam("mainImage") MultipartFile uploadFile, Model model) {
        // 이미지 저장 경로
        String uploadFolder = "C:/resources/images/upload";

        // 날짜별 폴더 구조 생성 (예: 2025/05/19)
        String datePath = new SimpleDateFormat("yyyy/MM/dd").format(new Date());
        File uploadPath = new File(uploadFolder, datePath);

        if (!uploadPath.exists()) {
            boolean dirsCreated = uploadPath.mkdirs();  // 경로(폴더)가 없으면 생성
            log.info("폴더 생성 여부: " + dirsCreated);
        }

        List<String> imgPaths = new ArrayList<>();

        if (uploadFile.isEmpty()) {
            log.warn("빈 파일이 업로드되었습니다.");
        } else {
            String originalFileName = uploadFile.getOriginalFilename();

            if (originalFileName == null || originalFileName.trim().isEmpty()) {
                log.warn("파일명이 비어있거나 null입니다.");
            } else {
                int dotIndex = originalFileName.lastIndexOf(".");
                if (dotIndex == -1) {
                    log.warn("확장자가 없는 파일입니다: " + originalFileName);
                } else {
                    String ext = originalFileName.substring(dotIndex + 1).toLowerCase();

                    if (!List.of("png", "jpg", "jpeg", "webp", "gif").contains(ext)) {
                        log.warn("허용되지 않는 파일 확장자: " + ext);
                    } else {
                        String uuid = UUID.randomUUID().toString();
                        String fileName = uuid + "_" + originalFileName;
                        File saveFile = new File(uploadPath, fileName);

                        try {
                            uploadFile.transferTo(saveFile);
                            log.info("파일 업로드 성공: " + fileName);

                            // 썸네일 생성
                            if (ext.equals("jpg") || ext.equals("jpeg") || ext.equals("png") || ext.equals("webp")) {
                                createThumbnail(saveFile, uploadPath, fileName, ext);
                            }

                            String imgPath = "/resources/images/" + datePath + "/" + fileName;
                            imgPaths.add(imgPath);

                        } catch (IOException e) {
                            log.error("파일 저장 실패: " + e.getMessage(), e);
                        }
                    }
                }
            }
        }

        if (imgPaths.isEmpty()) {
            log.info("파일 업로드가 실패했습니다.");
        } else {
            log.info("총 " + imgPaths.size() + "개의 파일이 업로드되었습니다.");
        }

        model.addAttribute("imgPaths", imgPaths);

        return "board/register";
    }

    // 썸네일 생성 메서드
    private void createThumbnail(File originalFile, File uploadPath, String fileName, String ext) throws IOException {
        BufferedImage originalImage = ImageIO.read(originalFile);
        int width = originalImage.getWidth() / 2;
        int height = originalImage.getHeight() / 2;
        BufferedImage thumbnailImage = new BufferedImage(width, height, originalImage.getType());

        thumbnailImage.getGraphics().drawImage(originalImage, 0, 0, width, height, null);

        File thumbnailFile = new File(uploadPath, "thumb_" + fileName);
        ImageIO.write(thumbnailImage, ext, thumbnailFile);
        log.info("썸네일 생성 성공: " + thumbnailFile.getName());
    }
}
