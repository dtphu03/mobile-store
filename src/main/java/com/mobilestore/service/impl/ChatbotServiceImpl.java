//package com.mobilestore.service.impl;
//
//import com.mobilestore.dto.ChatbotRequest;
//import com.mobilestore.dto.ChatbotResponse;
//import com.mobilestore.entities.SanPham;
//import com.mobilestore.entities.QSanPham;
//import com.mobilestore.repository.SanPhamRepository;
//import com.mobilestore.service.ChatbotService;
//import com.mobilestore.ulti.GeminiClient;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.util.Comparator;
//import java.util.List;
//import java.util.stream.Collectors;
//
//@Service
//public class ChatbotServiceImpl implements ChatbotService {
//
//	@Autowired
//	private SanPhamRepository sanPhamRepository;
//
//	@Autowired
//	private GeminiClient geminiClient;
//
//	@Override
//	public ChatbotResponse ask(ChatbotRequest request) {
//		String question = request.getQuestion() == null ? "" : request.getQuestion().trim();
//		List<SanPham> topProducts = findRelevantProducts(question, 3);
//
//		StringBuilder prompt = new StringBuilder();
//		prompt.append("Bạn là chuyên gia tư vấn điện thoại. Trả lời ngắn gọn, dễ hiểu, tiếng Việt.\n");
//		prompt.append("Câu hỏi khách hàng: \"" + question + "\"\n\n");
//		prompt.append("Một số sản phẩm gợi ý (tối đa 3):\n");
//		for (SanPham sp : topProducts) {
//			prompt.append("- Tên: ").append(sp.getTenSanPham())
//				.append(", Giá: ").append(sp.getDonGia())
//				.append(", Hãng: ").append(sp.getHangSanXuat() != null ? sp.getHangSanXuat().getTenHangSanXuat() : "?")
//				.append(", HĐH: ").append(sp.getHeDieuHanh() != null ? sp.getHeDieuHanh() : "?")
//				.append(", RAM: ").append(sp.getRam() != null ? sp.getRam() : "?")
//				.append(", Pin: ").append(sp.getDungLuongPin() != null ? sp.getDungLuongPin() : "?")
//				.append("\n");
//		}
//		prompt.append("\nHãy tư vấn sản phẩm phù hợp và giải thích ngắn gọn.");
//
//		String answer = geminiClient.generateText(prompt.toString());
//		return new ChatbotResponse(answer);
//	}
//
//	private List<SanPham> findRelevantProducts(String question, int limit) {
//		String normalized = question == null ? "" : question.toLowerCase();
//		long minPrice = -1L; long maxPrice = -1L;
//		// Suy luận khoảng giá từ "triệu"
//		if (normalized.contains("duoi") || normalized.contains("dưới")) {
//			String num = normalized.replaceAll(".*?(\\d+)[\\s]*triệu.*", "$1");
//			try { maxPrice = Long.parseLong(num) * 1_000_000L; } catch (Exception ignored) {}
//		} else if (normalized.contains("tren") || normalized.contains("trên")) {
//			String num = normalized.replaceAll(".*?(\\d+)[\\s]*triệu.*", "$1");
//			try { minPrice = Long.parseLong(num) * 1_000_000L; } catch (Exception ignored) {}
//		} else if (normalized.matches(".*?\\d+[\\s]*-[\\s]*\\d+.*?triệu.*")) {
//			String a = normalized.replaceAll(".*?(\\d+)[\\s]*-[\\s]*(\\d+).*?triệu.*", "$1");
//			String b = normalized.replaceAll(".*?(\\d+)[\\s]*-[\\s]*(\\d+).*?triệu.*", "$2");
//			try { long x = Long.parseLong(a) * 1_000_000L; long y = Long.parseLong(b) * 1_000_000L; minPrice = Math.min(x,y); maxPrice = Math.max(x,y);} catch (Exception ignored) {}
//		} else if (normalized.matches(".*?(?:khoảng|tam|tầm|~)?[\\s]*\\d+.*?triệu.*")) {
//			String num = normalized.replaceAll(".*?(\\d+).*?triệu.*", "$1");
//			try { long mid = Long.parseLong(num) * 1_000_000L; minPrice = Math.max(0, mid - 2_000_000L); maxPrice = mid + 2_000_000L; } catch (Exception ignored) {}
//		}
//
//		// Xây dựng predicate theo từ khóa linh hoạt: tên SP, danh mục, hãng SX, HĐH
//		com.querydsl.core.BooleanBuilder builder = new com.querydsl.core.BooleanBuilder();
//		// Bóc các từ khóa >=3 ký tự (bỏ dấu câu cơ bản)
//		String[] tokens = normalized.replaceAll("[\\p{Punct}]", " ").split("\\s+");
//		com.querydsl.core.BooleanBuilder keywordOr = new com.querydsl.core.BooleanBuilder();
//		for (String t : tokens) {
//			if (t.length() < 3) continue;
//			keywordOr.or(QSanPham.sanPham.tenSanPham.likeIgnoreCase("%" + t + "%"))
//				.or(QSanPham.sanPham.danhMuc.tenDanhMuc.likeIgnoreCase("%" + t + "%"))
//				.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%" + t + "%"))
//				.or(QSanPham.sanPham.heDieuHanh.likeIgnoreCase("%" + t + "%"));
//		}
//		// Bổ sung các từ khóa domain thông dụng
//		if (normalized.contains("android")) keywordOr.or(QSanPham.sanPham.heDieuHanh.likeIgnoreCase("%Android%"));
//		if (normalized.contains("ios") || normalized.contains("iphone")) keywordOr.or(QSanPham.sanPham.heDieuHanh.likeIgnoreCase("%ios%"));
//		if (normalized.contains("samsung")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%Samsung%"));
//		if (normalized.contains("xiaomi")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%Xiaomi%"));
//		if (normalized.contains("oppo")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%Oppo%"));
//		if (normalized.contains("vivo")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%Vivo%"));
//		if (normalized.contains("realme")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%Realme%"));
//		if (normalized.contains("apple") || normalized.contains("macbook")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%Apple%"));
//		builder.and(keywordOr);
//
//		// Áp dụng khoảng giá nếu có
//		if (minPrice >= 0 && maxPrice >= 0) builder.and(QSanPham.sanPham.donGia.between(minPrice, maxPrice));
//		else if (minPrice >= 0) builder.and(QSanPham.sanPham.donGia.goe(minPrice));
//		else if (maxPrice >= 0) builder.and(QSanPham.sanPham.donGia.loe(maxPrice));
//
////		org.springframework.data.domain.Pageable pageable = org.springframework.data.domain.PageRequest.of(0, Math.max(1, limit),
////			org.springframework.data.domain.Sort.by(
////				org.springframework.data.domain.Sort.Order.desc("salesCount"),
////				org.springframework.data.domain.Sort.Order.desc("id")
////			)
////		);
//		org.springframework.data.domain.Pageable pageable = org.springframework.data.domain.PageRequest.of(0, Math.max(1, limit));
//		org.springframework.data.domain.Page<SanPham> page = sanPhamRepository.findAll(builder, pageable);
//		List<SanPham> list = page.getContent();
//		if (list.isEmpty()) {
//			// Fallback rất rộng: chọn theo tên hoặc danh mục có chứa bất kỳ token dài >=3
//			list = sanPhamRepository.findAll().stream()
//				.filter(sp -> {
//					String name = sp.getTenSanPham() == null ? "" : sp.getTenSanPham().toLowerCase();
//					String dm = sp.getDanhMuc() == null || sp.getDanhMuc().getTenDanhMuc() == null ? "" : sp.getDanhMuc().getTenDanhMuc().toLowerCase();
//					for (String t : tokens) { if (t.length() >= 3 && (name.contains(t) || dm.contains(t))) return true; }
//					return false;
//				})
//				.sorted(Comparator.comparingLong(SanPham::getDonGia).reversed())
//				.limit(Math.max(1, limit))
//				.collect(Collectors.toList());
//		}
//		return list;
//	}
//}
//
//

package com.mobilestore.service.impl;

import com.mobilestore.dto.ChatbotRequest;
import com.mobilestore.dto.ChatbotResponse;
import com.mobilestore.entities.SanPham;
import com.mobilestore.entities.QSanPham;
import com.mobilestore.repository.SanPhamRepository;
import com.mobilestore.service.ChatbotService;
import com.mobilestore.ulti.GeminiClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@Service
public class ChatbotServiceImpl implements ChatbotService {

	private static final Logger log = Logger.getLogger(ChatbotServiceImpl.class.getName());

	@Autowired
	private SanPhamRepository sanPhamRepository;

	@Autowired
	private GeminiClient geminiClient;

	@Override
	public ChatbotResponse ask(ChatbotRequest request) {
		String question = safeLowerCase(request.getQuestion());
		List<SanPham> topProducts = findRelevantProducts(question, 3);

		StringBuilder prompt = new StringBuilder();
		prompt.append("Bạn là chuyên gia tư vấn điện thoại. Trả lời ngắn gọn, dễ hiểu, tiếng Việt.\n");
		prompt.append("Câu hỏi khách hàng: \"" + question + "\"\n\n");
		prompt.append("Một số sản phẩm gợi ý (tối đa 3):\n");
		for (SanPham sp : topProducts) {
			prompt.append("- Tên: ").append(sp.getTenSanPham())
					.append(", Giá: ").append(sp.getDonGia())
					.append(", Hãng: ").append(sp.getHangSanXuat() != null ? sp.getHangSanXuat().getTenHangSanXuat() : "?")
					.append(", HĐH: ").append(sp.getHeDieuHanh() != null ? sp.getHeDieuHanh() : "?")
					.append(", RAM: ").append(sp.getRam() != null ? sp.getRam() : "?")
					.append(", Pin: ").append(sp.getDungLuongPin() != null ? sp.getDungLuongPin() : "?")
					.append("\n");
		}
		prompt.append("\nHãy tư vấn sản phẩm phù hợp và giải thích ngắn gọn.");

		String answer = geminiClient.generateText(prompt.toString());
		return new ChatbotResponse(answer);
	}

	private List<SanPham> findRelevantProducts(String question, int limit) {
		String normalized = safeLowerCase(question);

		long minPrice = -1L, maxPrice = -1L;
		// Xử lý trường hợp "trên X triệu dưới Y triệu"
		if (normalized.contains("trên") && normalized.contains("dưới")) {
			String minNum = normalized.replaceAll(".*?trên[\\s]*(\\d+)[\\s]*triệu.*", "$1");
			String maxNum = normalized.replaceAll(".*?dưới[\\s]*(\\d+)[\\s]*triệu.*", "$1");
			try {
				minPrice = Long.parseLong(minNum) * 1_000_000L;
				maxPrice = Long.parseLong(maxNum) * 1_000_000L;
				if (minPrice > maxPrice) {
					long temp = minPrice;
					minPrice = maxPrice;
					maxPrice = temp;
				}
			} catch (NumberFormatException e) {
				log.warning("Không thể phân tích khoảng giá: trên " + minNum + " triệu, dưới " + maxNum + " triệu");
			}
		} else if (normalized.contains("dưới")) {
			String num = normalized.replaceAll(".*?(\\d+)[\\s]*triệu.*", "$1");
			try {
				maxPrice = Long.parseLong(num) * 1_000_000L;
			} catch (NumberFormatException e) {
				log.warning("Không thể phân tích giá dưới: " + num);
			}
		} else if (normalized.contains("trên")) {
			String num = normalized.replaceAll(".*?(\\d+)[\\s]*triệu.*", "$1");
			try {
				minPrice = Long.parseLong(num) * 1_000_000L;
			} catch (NumberFormatException e) {
				log.warning("Không thể phân tích giá trên: " + num);
			}
		} else if (normalized.matches(".*?\\d+[\\s]*-[\\s]*\\d+.*?triệu.*")) {
			String a = normalized.replaceAll(".*?(\\d+)[\\s]*-[\\s]*(\\d+).*?triệu.*", "$1");
			String b = normalized.replaceAll(".*?(\\d+)[\\s]*-[\\s]*(\\d+).*?triệu.*", "$2");
			try {
				long x = Long.parseLong(a) * 1_000_000L;
				long y = Long.parseLong(b) * 1_000_000L;
				minPrice = Math.min(x, y);
				maxPrice = Math.max(x, y);
			} catch (NumberFormatException e) {
				log.warning("Không thể phân tích khoảng giá: " + a + "-" + b);
			}
		} else if (normalized.matches(".*?(?:khoảng|tầm|~)?[\\s]*\\d+.*?triệu.*")) {
			String num = normalized.replaceAll(".*?(\\d+).*?triệu.*", "$1");
			try {
				long mid = Long.parseLong(num) * 1_000_000L;
				minPrice = Math.max(0, mid - 2_000_000L);
				maxPrice = mid + 2_000_000L;
			} catch (NumberFormatException e) {
				log.warning("Không thể phân tích giá tầm: " + num);
			}
		}

		com.querydsl.core.BooleanBuilder builder = new com.querydsl.core.BooleanBuilder();
		com.querydsl.core.BooleanBuilder keywordOr = new com.querydsl.core.BooleanBuilder();
		String[] tokens = normalized.replaceAll("[\\p{Punct}]", " ").split("\\s+");
		for (String t : Arrays.stream(tokens).filter(t -> t.length() >= 3).limit(5).toArray(String[]::new)) {
			keywordOr.or(QSanPham.sanPham.tenSanPham.likeIgnoreCase("%" + t + "%"))
					.or(QSanPham.sanPham.danhMuc.tenDanhMuc.likeIgnoreCase("%" + t + "%"))
					.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%" + t + "%"))
					.or(QSanPham.sanPham.heDieuHanh.likeIgnoreCase("%" + t + "%"));
		}
		if (normalized.contains("android")) keywordOr.or(QSanPham.sanPham.heDieuHanh.likeIgnoreCase("%android%"));
		if (normalized.contains("ios") || normalized.contains("iphone")) keywordOr.or(QSanPham.sanPham.heDieuHanh.likeIgnoreCase("%ios%"));
		if (normalized.contains("samsung")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%samsung%"));
		if (normalized.contains("xiaomi")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%xiaomi%"));
		if (normalized.contains("oppo")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%oppo%"));
		if (normalized.contains("vivo")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%vivo%"));
		if (normalized.contains("realme")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%realme%"));
		if (normalized.contains("apple") || normalized.contains("macbook")) keywordOr.or(QSanPham.sanPham.hangSanXuat.tenHangSanXuat.likeIgnoreCase("%apple%"));
		builder.and(keywordOr);

		if (minPrice >= 0 && maxPrice >= 0) {
			builder.and(QSanPham.sanPham.donGia.between(minPrice, maxPrice));
		} else if (minPrice >= 0) {
			builder.and(QSanPham.sanPham.donGia.goe(minPrice));
		} else if (maxPrice >= 0) {
			builder.and(QSanPham.sanPham.donGia.loe(maxPrice));
		}

		Pageable pageable = PageRequest.of(0, Math.max(1, limit), Sort.by(Sort.Order.desc("salesCount"), Sort.Order.desc("id")));
		Page<SanPham> page = sanPhamRepository.findAll(builder, pageable);
		List<SanPham> list = page.getContent();

		if (list.isEmpty()) {
			list = sanPhamRepository.findAll().stream()
					.filter(sp -> {
						String name = safeLowerCase(sp.getTenSanPham());
						String dm = safeLowerCase(sp.getDanhMuc() != null ? sp.getDanhMuc().getTenDanhMuc() : "");
						return Arrays.stream(tokens).anyMatch(t -> t.length() >= 3 && (name.contains(t) || dm.contains(t)));
					})
					.sorted(Comparator.comparingLong(SanPham::getDonGia).reversed())
					.limit(Math.max(1, limit))
					.collect(Collectors.toList());
		}
		return list;
	}

	private String safeLowerCase(String value) {
		return value == null ? "" : value.toLowerCase();
	}
}
