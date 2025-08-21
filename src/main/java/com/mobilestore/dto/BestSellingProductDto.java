package com.mobilestore.dto;

public class BestSellingProductDto {

    private Long id;
    private String tenSanPham;
    private String donGia;
    private String hinhAnh;
    private String danhMucTen;
    private String hangSanXuatTen;
    private Long salesCount;
    private Integer ratingCount;
    private Integer ratingSum;
    private Double ratingAverage;

    public BestSellingProductDto() {
    }

    public BestSellingProductDto(Long id, String tenSanPham, String donGia, String hinhAnh, 
                                String danhMucTen, String hangSanXuatTen, Long salesCount, 
                                Integer ratingCount, Integer ratingSum, Double ratingAverage) {
        this.id = id;
        this.tenSanPham = tenSanPham;
        this.donGia = donGia;
        this.hinhAnh = hinhAnh;
        this.danhMucTen = danhMucTen;
        this.hangSanXuatTen = hangSanXuatTen;
        this.salesCount = salesCount;
        this.ratingCount = ratingCount;
        this.ratingSum = ratingSum;
        this.ratingAverage = ratingAverage;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTenSanPham() {
        return tenSanPham;
    }

    public void setTenSanPham(String tenSanPham) {
        this.tenSanPham = tenSanPham;
    }

    public String getDonGia() {
        return donGia;
    }

    public void setDonGia(String donGia) {
        this.donGia = donGia;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

    public String getDanhMucTen() {
        return danhMucTen;
    }

    public void setDanhMucTen(String danhMucTen) {
        this.danhMucTen = danhMucTen;
    }

    public String getHangSanXuatTen() {
        return hangSanXuatTen;
    }

    public void setHangSanXuatTen(String hangSanXuatTen) {
        this.hangSanXuatTen = hangSanXuatTen;
    }

    public Long getSalesCount() {
        return salesCount;
    }

    public void setSalesCount(Long salesCount) {
        this.salesCount = salesCount;
    }

    public Integer getRatingCount() {
        return ratingCount;
    }

    public void setRatingCount(Integer ratingCount) {
        this.ratingCount = ratingCount;
    }

    public Integer getRatingSum() {
        return ratingSum;
    }

    public void setRatingSum(Integer ratingSum) {
        this.ratingSum = ratingSum;
    }

    public Double getRatingAverage() {
        return ratingAverage;
    }

    public void setRatingAverage(Double ratingAverage) {
        this.ratingAverage = ratingAverage;
    }

    @Override
    public String toString() {
        return "BestSellingProductDto{" +
                "id=" + id +
                ", tenSanPham='" + tenSanPham + '\'' +
                ", donGia='" + donGia + '\'' +
                ", hinhAnh='" + hinhAnh + '\'' +
                ", danhMucTen='" + danhMucTen + '\'' +
                ", hangSanXuatTen='" + hangSanXuatTen + '\'' +
                ", salesCount=" + salesCount +
                ", ratingCount=" + ratingCount +
                ", ratingSum=" + ratingSum +
                ", ratingAverage=" + ratingAverage +
                '}';
    }
}