from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import cm
from reportlab.lib import colors
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle,
    PageBreak, HRFlowable, KeepTogether
)
from reportlab.lib.enums import TA_CENTER, TA_LEFT, TA_JUSTIFY
from reportlab.platypus import Flowable

# ── Warna tema ──────────────────────────────────────────────────────────────
BIRU_TUA   = colors.HexColor("#1A3A5C")
BIRU_MUDA  = colors.HexColor("#2E86C1")
BIRU_PALE  = colors.HexColor("#D6EAF8")
HIJAU_TUA  = colors.HexColor("#1E6E45")
HIJAU_MUDA = colors.HexColor("#27AE60")
HIJAU_PALE = colors.HexColor("#D5F5E3")
ORANYE_TUA = colors.HexColor("#7D4E00")
ORANYE_MED = colors.HexColor("#D68910")
ORANYE_PALE= colors.HexColor("#FEF9E7")
ABU_TUA    = colors.HexColor("#2C3E50")
ABU_MUDA   = colors.HexColor("#85929E")
ABU_PALE   = colors.HexColor("#F2F3F4")
PUTIH      = colors.HexColor("#FFFFFF")
MERAH      = colors.HexColor("#C0392B")
MERAH_PALE = colors.HexColor("#FADBD8")
COKLAT_PALE= colors.HexColor("#FDF2E9")

# ── Styles ───────────────────────────────────────────────────────────────────
styles = getSampleStyleSheet()

def S(name, **kw):
    return ParagraphStyle(name, **kw)

# Cover
sJudul     = S("Judul",     fontSize=30, fontName="Helvetica-Bold", textColor=PUTIH,
                alignment=TA_CENTER, leading=38)
sSubJudul  = S("SubJudul",  fontSize=14, fontName="Helvetica",      textColor=PUTIH,
                alignment=TA_CENTER, leading=20, spaceAfter=6)
sBadge     = S("Badge",     fontSize=11, fontName="Helvetica-Bold",  textColor=BIRU_MUDA,
                alignment=TA_CENTER)

# Navigasi / chapter
sBAB       = S("BAB",       fontSize=20, fontName="Helvetica-Bold", textColor=PUTIH,
                alignment=TA_LEFT, leading=26, spaceBefore=0, spaceAfter=0)
sBABSub    = S("BABSub",    fontSize=11, fontName="Helvetica",      textColor=PUTIH,
                alignment=TA_LEFT, leading=16, spaceBefore=0, spaceAfter=0)

# Headings
sH1        = S("H1",        fontSize=16, fontName="Helvetica-Bold", textColor=BIRU_TUA,
                spaceBefore=14, spaceAfter=4, leading=22)
sH2        = S("H2",        fontSize=13, fontName="Helvetica-Bold", textColor=BIRU_MUDA,
                spaceBefore=10, spaceAfter=3, leading=18)
sH3        = S("H3",        fontSize=11, fontName="Helvetica-Bold", textColor=ABU_TUA,
                spaceBefore=8,  spaceAfter=2, leading=16)

# Body
sBody      = S("Body",      fontSize=10, fontName="Helvetica",      textColor=ABU_TUA,
                spaceBefore=3,  spaceAfter=3, leading=15, alignment=TA_JUSTIFY)
sBullet    = S("Bullet",    fontSize=10, fontName="Helvetica",      textColor=ABU_TUA,
                leftIndent=16, bulletIndent=4, spaceBefore=2, spaceAfter=2, leading=15)
sCode      = S("Code",      fontSize=9.5,fontName="Courier",        textColor=BIRU_TUA,
                leftIndent=12, spaceBefore=2, spaceAfter=2, leading=14,
                backColor=colors.HexColor("#EBF5FB"))

sInfo      = S("Info",      fontSize=9.5,fontName="Helvetica-Oblique", textColor=ABU_MUDA,
                spaceBefore=2, spaceAfter=2, leading=14)

# ── Custom Flowable: Kotak bertulisan ────────────────────────────────────────
class ColorBox(Flowable):
    def __init__(self, text, fg, bg, width=None, height=28, font_size=11, bold=True):
        super().__init__()
        self.text = text; self.fg = fg; self.bg = bg
        self.bw = width or (A4[0] - 4*cm)
        self.bh = height; self.fs = font_size; self.bold = bold
    def wrap(self, aw, ah): return self.bw, self.bh + 8
    def draw(self):
        self.canv.setFillColor(self.bg)
        self.canv.roundRect(0, 4, self.bw, self.bh, 5, stroke=0, fill=1)
        fname = "Helvetica-Bold" if self.bold else "Helvetica"
        self.canv.setFont(fname, self.fs)
        self.canv.setFillColor(self.fg)
        self.canv.drawString(10, 4 + self.bh/2 - self.fs/2 + 1, self.text)

class CoverBlock(Flowable):
    "Full-width blok warna untuk cover header"
    def __init__(self, color, height):
        super().__init__()
        self.color = color; self.height = height
    def wrap(self, aw, ah): return aw, self.height
    def draw(self):
        self.canv.setFillColor(self.color)
        self.canv.rect(0, 0, A4[0], self.height, stroke=0, fill=1)

# ── Fungsi bantu ─────────────────────────────────────────────────────────────
def space(h=6): return Spacer(1, h)
def hr(color=BIRU_PALE, thick=0.5): return HRFlowable(width="100%", thickness=thick, color=color)

def bab_header(nomor, judul, subjudul, warna_bg, warna_text=PUTIH):
    tbl = Table([[
        Paragraph(f"BAB {nomor}", S("BN", fontSize=10, fontName="Helvetica",
                  textColor=warna_text, leading=13)),
        ""
    ],[
        Paragraph(judul, S("BJ", fontSize=18, fontName="Helvetica-Bold",
                  textColor=warna_text, leading=24)),
        ""
    ],[
        Paragraph(subjudul, S("BS", fontSize=10, fontName="Helvetica",
                  textColor=warna_text, leading=14, spaceBefore=4)),
        ""
    ]],
    colWidths=["85%","15%"])
    tbl.setStyle(TableStyle([
        ("BACKGROUND", (0,0),(-1,-1), warna_bg),
        ("TOPPADDING",    (0,0),(-1,-1), 14),
        ("BOTTOMPADDING", (0,0),(-1,-1), 14),
        ("LEFTPADDING",   (0,0),(-1,-1), 16),
        ("RIGHTPADDING",  (0,0),(-1,-1), 16),
        ("ROWBACKGROUNDS",(0,0),(-1,-1), [warna_bg]),
        ("ROUNDEDCORNERS",(0,0),(-1,-1), [6]),
        ("SPAN",          (0,0),(1,0)),
        ("SPAN",          (0,1),(1,1)),
        ("SPAN",          (0,2),(1,2)),
    ]))
    return tbl

def sub_header(teks, bg, fg=PUTIH):
    tbl = Table([[Paragraph(teks, S("SH", fontSize=12, fontName="Helvetica-Bold",
                 textColor=fg, leading=17))]],
                colWidths=[A4[0]-4*cm])
    tbl.setStyle(TableStyle([
        ("BACKGROUND", (0,0),(0,0), bg),
        ("TOPPADDING",    (0,0),(0,0), 8),
        ("BOTTOMPADDING", (0,0),(0,0), 8),
        ("LEFTPADDING",   (0,0),(0,0), 12),
        ("ROUNDEDCORNERS",(0,0),(0,0), [5]),
    ]))
    return tbl

def tag_item(label, color_bg, color_fg):
    tbl = Table([[Paragraph(label, S("TG", fontSize=9.5, fontName="Helvetica-Bold",
                 textColor=color_fg, leading=14))]],
                colWidths=[A4[0]-4*cm])
    tbl.setStyle(TableStyle([
        ("BACKGROUND", (0,0),(0,0), color_bg),
        ("TOPPADDING",    (0,0),(0,0), 5),
        ("BOTTOMPADDING", (0,0),(0,0), 5),
        ("LEFTPADDING",   (0,0),(0,0), 10),
        ("ROUNDEDCORNERS",(0,0),(0,0), [4]),
    ]))
    return tbl

def alur_box(items, bg, fg):
    "Kotak alur dengan panah"
    rows = []
    for i, itm in enumerate(items):
        rows.append([Paragraph(itm, S("AF", fontSize=10, fontName="Helvetica-Bold",
                    textColor=fg, leading=15))])
        if i < len(items)-1:
            rows.append([Paragraph("↓", S("AR", fontSize=14, fontName="Helvetica-Bold",
                         textColor=fg, leading=18, alignment=TA_CENTER))])
    t = Table(rows, colWidths=[A4[0]-4*cm])
    style = []
    for i in range(len(rows)):
        if i % 2 == 0:
            style += [
                ("BACKGROUND",    (0,i),(0,i), bg),
                ("TOPPADDING",    (0,i),(0,i), 7),
                ("BOTTOMPADDING", (0,i),(0,i), 7),
                ("LEFTPADDING",   (0,i),(0,i), 14),
                ("ROUNDEDCORNERS",(0,i),(0,i), [4]),
            ]
        else:
            style += [
                ("TOPPADDING",    (0,i),(0,i), 1),
                ("BOTTOMPADDING", (0,i),(0,i), 1),
                ("LEFTPADDING",   (0,i),(0,i), A4[0]/2 - 3*cm),
            ]
    t.setStyle(TableStyle(style))
    return t

def info_box(teks, bg=BIRU_PALE, fg=BIRU_TUA):
    tbl = Table([[Paragraph(teks, S("IB", fontSize=9.5, fontName="Helvetica-Oblique",
                 textColor=fg, leading=14))]],
                colWidths=[A4[0]-4*cm])
    tbl.setStyle(TableStyle([
        ("BACKGROUND",    (0,0),(0,0), bg),
        ("TOPPADDING",    (0,0),(0,0), 10),
        ("BOTTOMPADDING", (0,0),(0,0), 10),
        ("LEFTPADDING",   (0,0),(0,0), 14),
        ("RIGHTPADDING",  (0,0),(0,0), 14),
        ("ROUNDEDCORNERS",(0,0),(0,0), [5]),
        ("BOX",           (0,0),(0,0), 0.8, fg),
    ]))
    return tbl

def prioritas_table(items, warna_no, warna_row_alt):
    rows = [["No", "Materi"]]
    for i, itm in enumerate(items, 1):
        rows.append([str(i), itm])
    t = Table(rows, colWidths=[1.2*cm, A4[0]-4*cm-1.2*cm])
    ts = [
        ("BACKGROUND",    (0,0),(-1,0), warna_no),
        ("TEXTCOLOR",     (0,0),(-1,0), PUTIH),
        ("FONTNAME",      (0,0),(-1,0), "Helvetica-Bold"),
        ("FONTSIZE",      (0,0),(-1,0), 10),
        ("BOTTOMPADDING", (0,0),(-1,0), 7),
        ("TOPPADDING",    (0,0),(-1,0), 7),
        ("LEFTPADDING",   (0,0),(-1,0), 10),
        ("FONTNAME",      (0,1),(-1,-1),"Helvetica"),
        ("FONTSIZE",      (0,1),(-1,-1), 10),
        ("BOTTOMPADDING", (0,1),(-1,-1), 6),
        ("TOPPADDING",    (0,1),(-1,-1), 6),
        ("LEFTPADDING",   (0,1),(-1,-1), 10),
        ("TEXTCOLOR",     (0,1),(-1,-1), ABU_TUA),
        ("ALIGN",         (0,0),(0,-1), "CENTER"),
        ("VALIGN",        (0,0),(-1,-1),"MIDDLE"),
        ("GRID",          (0,0),(-1,-1), 0.4, colors.HexColor("#D0D3D4")),
    ]
    for i in range(1, len(rows)):
        if i % 2 == 0:
            ts.append(("BACKGROUND", (0,i),(-1,i), warna_row_alt))
        else:
            ts.append(("BACKGROUND", (0,i),(-1,i), PUTIH))
    ts.append(("FONTNAME", (0,1),(0,-1), "Helvetica-Bold"))
    ts.append(("TEXTCOLOR",(0,1),(0,-1), warna_no))
    t.setStyle(TableStyle(ts))
    return t

# ── Halaman Cover ────────────────────────────────────────────────────────────
def cover_page():
    elems = []

    # Header biru besar
    hdr = Table([[
        "",
        Paragraph("PANDUAN BELAJAR", S("PB", fontSize=11, fontName="Helvetica",
                  textColor=colors.HexColor("#AED6F1"), alignment=TA_CENTER)),
        ""
    ],[
        "",
        Paragraph("TES KEMAMPUAN\nAKADEMIK (TKA)", S("TKA", fontSize=28,
                  fontName="Helvetica-Bold", textColor=PUTIH, alignment=TA_CENTER, leading=36)),
        ""
    ],[
        "",
        Paragraph("SMK / MAK Kelas 12", S("Kls", fontSize=13, fontName="Helvetica",
                  textColor=colors.HexColor("#AED6F1"), alignment=TA_CENTER, leading=18)),
        ""
    ]],
    colWidths=["10%","80%","10%"],
    rowHeights=[30, 100, 30])
    hdr.setStyle(TableStyle([
        ("BACKGROUND",    (0,0),(-1,-1), BIRU_TUA),
        ("TOPPADDING",    (0,0),(-1,-1), 0),
        ("BOTTOMPADDING", (0,0),(-1,-1), 0),
    ]))
    elems += [hdr, space(20)]

    # 3 Badge mapel
    badges = Table([[
        Paragraph("📐  MATEMATIKA", S("B1", fontSize=12, fontName="Helvetica-Bold",
                  textColor=BIRU_TUA, alignment=TA_CENTER)),
        Paragraph("📖  BAHASA INDONESIA", S("B2", fontSize=12, fontName="Helvetica-Bold",
                  textColor=HIJAU_TUA, alignment=TA_CENTER)),
        Paragraph("🌐  BAHASA INGGRIS", S("B3", fontSize=12, fontName="Helvetica-Bold",
                  textColor=ORANYE_TUA, alignment=TA_CENTER)),
    ]],
    colWidths=["33%","34%","33%"])
    badges.setStyle(TableStyle([
        ("BACKGROUND",    (0,0),(0,0), BIRU_PALE),
        ("BACKGROUND",    (1,0),(1,0), HIJAU_PALE),
        ("BACKGROUND",    (2,0),(2,0), ORANYE_PALE),
        ("TOPPADDING",    (0,0),(-1,-1), 14),
        ("BOTTOMPADDING", (0,0),(-1,-1), 14),
        ("LEFTPADDING",   (0,0),(-1,-1), 8),
        ("RIGHTPADDING",  (0,0),(-1,-1), 8),
        ("ROUNDEDCORNERS",(0,0),(-1,-1), [6]),
        ("LINEAFTER",     (0,0),(1,0),  0.5, colors.HexColor("#CCCCCC")),
    ]))
    elems += [badges, space(22)]

    elems.append(hr(BIRU_PALE, 1))
    elems.append(space(14))

    elems.append(Paragraph(
        "Disusun berdasarkan kisi-kisi resmi Pusat Asesmen Pendidikan (Pusmendik)",
        S("SR", fontSize=10, fontName="Helvetica-Oblique", textColor=ABU_MUDA, alignment=TA_CENTER)
    ))
    elems.append(Paragraph(
        "Peraturan Mendikdasmen No. 9 Tahun 2025 • Kerangka Asesmen TKA SMA/SMK",
        S("SR2", fontSize=10, fontName="Helvetica-Oblique", textColor=ABU_MUDA, alignment=TA_CENTER)
    ))
    elems.append(space(20))

    # Kotak tujuan
    tujuan = Table([[
        Paragraph(
            "<b>Panduan ini berisi:</b>  Urutan belajar dari dasar · Roadmap per mata pelajaran · "
            "Prioritas materi TKA · Jadwal belajar 4 bulan (Juni–Oktober)",
            S("TJ", fontSize=10, fontName="Helvetica", textColor=BIRU_TUA, leading=16))
    ]], colWidths=[A4[0]-4*cm])
    tujuan.setStyle(TableStyle([
        ("BACKGROUND",    (0,0),(0,0), BIRU_PALE),
        ("TOPPADDING",    (0,0),(0,0), 12),
        ("BOTTOMPADDING", (0,0),(0,0), 12),
        ("LEFTPADDING",   (0,0),(0,0), 16),
        ("RIGHTPADDING",  (0,0),(0,0), 16),
        ("ROUNDEDCORNERS",(0,0),(0,0), [6]),
    ]))
    elems.append(tujuan)
    elems.append(space(26))

    # Cara TKA berbeda dari UN
    elems.append(Paragraph("Yang Harus Kamu Pahami Dulu", sH1))
    elems.append(hr(BIRU_PALE))
    elems.append(space(8))
    elems.append(Paragraph(
        "TKA <b>bukan ujian hafalan</b> seperti UN. TKA mengukur kemampuan berpikir tingkat tinggi (HOTS). "
        "Banyak siswa nilainya rendah bukan karena materi sulit, tapi karena belum terbiasa dengan cara "
        "<i>bertanya</i> dan <i>menalar</i> yang dipakai TKA.",
        S("BB", fontSize=10.5, fontName="Helvetica", textColor=ABU_TUA, leading=16, alignment=TA_JUSTIFY)
    ))
    elems.append(space(12))

    rows5 = [["No", "Yang Diukur TKA"]]
    items5 = [
        "Pengetahuan konsep",
        "Kemampuan memahami informasi",
        "Kemampuan menerapkan konsep",
        "Kemampuan bernalar",
        "Kemampuan menyelesaikan masalah baru",
    ]
    for i, itm in enumerate(items5, 1):
        rows5.append([str(i), itm])
    t5 = Table(rows5, colWidths=[1.2*cm, A4[0]-4*cm-1.2*cm])
    t5.setStyle(TableStyle([
        ("BACKGROUND",    (0,0),(-1,0), BIRU_TUA),
        ("TEXTCOLOR",     (0,0),(-1,0), PUTIH),
        ("FONTNAME",      (0,0),(-1,0), "Helvetica-Bold"),
        ("FONTSIZE",      (0,0),(-1,0), 10),
        ("BOTTOMPADDING", (0,0),(-1,0), 7),
        ("TOPPADDING",    (0,0),(-1,0), 7),
        ("LEFTPADDING",   (0,0),(-1,0), 10),
        ("FONTNAME",      (0,1),(-1,-1), "Helvetica"),
        ("FONTSIZE",      (0,1),(-1,-1), 10),
        ("BOTTOMPADDING", (0,1),(-1,-1), 6),
        ("TOPPADDING",    (0,1),(-1,-1), 6),
        ("LEFTPADDING",   (0,1),(-1,-1), 10),
        ("TEXTCOLOR",     (0,1),(-1,-1), ABU_TUA),
        ("ALIGN",         (0,0),(0,-1), "CENTER"),
        ("VALIGN",        (0,0),(-1,-1), "MIDDLE"),
        ("GRID",          (0,0),(-1,-1), 0.4, colors.HexColor("#D0D3D4")),
        ("ROWBACKGROUNDS",(0,1),(-1,-1), [PUTIH, BIRU_PALE]),
        ("FONTNAME",      (0,1),(0,-1), "Helvetica-Bold"),
        ("TEXTCOLOR",     (0,1),(0,-1), BIRU_MUDA),
    ]))
    elems.append(t5)
    elems.append(space(16))
    elems.append(info_box(
        "PENTING: Karena TKA fokus pada penalaran, latihan soal kontekstual (soal cerita / masalah nyata) "
        "jauh lebih penting daripada menghafal rumus atau definisi.",
        MERAH_PALE, MERAH
    ))
    return elems

# ── BAB 1: MATEMATIKA ────────────────────────────────────────────────────────
def bab_matematika():
    elems = [PageBreak()]
    elems.append(bab_header("1", "MATEMATIKA", "5 Elemen Utama • Bilangan · Aljabar · Geometri · Trigonometri · Data", BIRU_TUA))
    elems.append(space(14))

    # Elemen A: Bilangan
    elems.append(KeepTogether([
        sub_header("A.  Bilangan", BIRU_MUDA),
        space(8),
        Paragraph("Materi yang dipelajari:", sH3),
    ]))
    materi_bil = [
        "Operasi bilangan (bulat, rasional, irasional)",
        "Pecahan",
        "Persentase",
        "Rasio dan Perbandingan",
        "Pangkat dan Akar",
        "Logaritma dasar",
        "Bilangan dalam notasi ilmiah",
    ]
    for m in materi_bil:
        elems.append(Paragraph(f"• {m}", sBullet))
    elems.append(space(10))
    elems.append(Paragraph("Urutan Belajar:", sH3))
    elems.append(alur_box([
        "Bilangan Bulat",
        "Pecahan",
        "Persentase",
        "Rasio dan Perbandingan",
        "Pangkat dan Akar",
        "Logaritma Dasar",
    ], BIRU_PALE, BIRU_TUA))
    elems.append(space(14))

    # Elemen B: Aljabar
    elems.append(sub_header("B.  Aljabar", BIRU_MUDA))
    elems.append(space(8))
    elems.append(Paragraph("Materi yang dipelajari:", sH3))
    materi_alj = [
        "Bentuk aljabar dan sifat-sifat operasinya",
        "Operasi aljabar",
        "Persamaan linear",
        "Pertidaksamaan linear",
        "Sistem Persamaan Linear Dua Variabel (SPLDV)",
        "Fungsi (domain, kodomain, range)",
        "Grafik fungsi",
        "Eksponen",
        "Barisan dan Deret (Aritmatika & Geometri)",
        "Matriks",
        "Persamaan kuadrat",
    ]
    for m in materi_alj:
        elems.append(Paragraph(f"• {m}", sBullet))
    elems.append(space(10))
    elems.append(Paragraph("Urutan Belajar:", sH3))
    elems.append(alur_box([
        "Variabel & Bentuk Aljabar",
        "Operasi Aljabar",
        "Persamaan Linear",
        "Pertidaksamaan",
        "SPLDV",
        "Fungsi",
        "Grafik Fungsi",
        "Eksponen & Logaritma",
        "Barisan & Deret",
        "Matriks",
    ], BIRU_PALE, BIRU_TUA))
    elems.append(space(14))

    # Elemen C: Geometri
    elems.append(sub_header("C.  Geometri dan Pengukuran", BIRU_MUDA))
    elems.append(space(8))
    elems.append(Paragraph("Materi yang dipelajari:", sH3))
    materi_geo = [
        "Bangun datar (segitiga, segiempat, lingkaran, dll.)",
        "Bangun ruang (kubus, balok, tabung, kerucut, bola)",
        "Luas dan Keliling bangun datar",
        "Volume dan Luas Permukaan bangun ruang",
        "Teorema Pythagoras",
        "Sudut dan hubungan antar sudut",
        "Transformasi geometri (translasi, refleksi, rotasi, dilatasi)",
    ]
    for m in materi_geo:
        elems.append(Paragraph(f"• {m}", sBullet))
    elems.append(space(10))
    elems.append(Paragraph("Urutan Belajar:", sH3))
    elems.append(alur_box([
        "Sudut (jenis & hubungan antar sudut)",
        "Bangun Datar (jenis & sifat)",
        "Keliling Bangun Datar",
        "Luas Bangun Datar",
        "Teorema Pythagoras",
        "Bangun Ruang (jenis & sifat)",
        "Volume Bangun Ruang",
        "Luas Permukaan",
        "Transformasi Geometri",
    ], BIRU_PALE, BIRU_TUA))
    elems.append(space(14))

    # Elemen D: Trigonometri
    elems.append(sub_header("D.  Trigonometri", BIRU_MUDA))
    elems.append(space(8))
    elems.append(Paragraph("Materi yang dipelajari:", sH3))
    materi_trig = [
        "Perbandingan trigonometri: Sin, Cos, Tan",
        "Sudut-sudut istimewa (0°, 30°, 45°, 60°, 90°)",
        "Identitas trigonometri dasar",
        "Aturan Sinus",
        "Aturan Cosinus",
        "Grafik fungsi trigonometri",
        "Aplikasi trigonometri dalam kehidupan nyata",
    ]
    for m in materi_trig:
        elems.append(Paragraph(f"• {m}", sBullet))
    elems.append(space(10))
    elems.append(Paragraph("Urutan Belajar:", sH3))
    elems.append(alur_box([
        "Sin, Cos, Tan (definisi & rumus)",
        "Sudut Istimewa",
        "Identitas Trigonometri",
        "Aturan Sinus & Cosinus",
        "Grafik Fungsi Trigonometri",
        "Aplikasi Trigonometri",
    ], BIRU_PALE, BIRU_TUA))
    elems.append(space(6))
    elems.append(info_box(
        "Trigonometri sering keluar karena sangat berguna untuk mengukur penalaran matematis.",
        BIRU_PALE, BIRU_TUA
    ))
    elems.append(space(14))

    # Elemen E: Data & Peluang
    elems.append(sub_header("E.  Data dan Peluang", BIRU_MUDA))
    elems.append(space(8))
    elems.append(Paragraph("Materi yang dipelajari:", sH3))
    materi_data = [
        "Mean (Rata-rata)",
        "Median",
        "Modus",
        "Diagram batang, garis, lingkaran",
        "Tabel frekuensi",
        "Interpretasi data dari grafik/tabel",
        "Peluang dasar kejadian",
    ]
    for m in materi_data:
        elems.append(Paragraph(f"• {m}", sBullet))
    elems.append(space(10))
    elems.append(Paragraph("Urutan Belajar:", sH3))
    elems.append(alur_box([
        "Mean, Median, Modus",
        "Diagram & Tabel Data",
        "Interpretasi Data",
        "Peluang Dasar",
    ], BIRU_PALE, BIRU_TUA))
    elems.append(space(6))
    elems.append(info_box(
        "Bagian ini sering muncul dalam bentuk grafik dan tabel yang harus dianalisis — bukan sekadar dihitung.",
        BIRU_PALE, BIRU_TUA
    ))
    elems.append(space(18))

    # Prioritas Matematika
    elems.append(PageBreak())
    elems.append(Paragraph("PRIORITAS BELAJAR MATEMATIKA", sH1))
    elems.append(hr(BIRU_PALE))
    elems.append(space(8))
    elems.append(Paragraph(
        "Jika waktumu terbatas, fokuslah pada urutan berikut. Urutan ini disusun berdasarkan bobot soal "
        "TKA dan keterkaitan antar materi.",
        S("PB2", fontSize=10, fontName="Helvetica", textColor=ABU_TUA, leading=15, alignment=TA_JUSTIFY)
    ))
    elems.append(space(10))
    elems.append(prioritas_table([
        "Aljabar (persamaan, fungsi, SPLDV)",
        "Fungsi dan Grafik Fungsi",
        "Persamaan & Pertidaksamaan",
        "Data dan Peluang",
        "Geometri (bangun datar & ruang)",
        "Trigonometri",
        "Bilangan (pangkat, akar, logaritma)",
    ], BIRU_MUDA, BIRU_PALE))
    elems.append(space(12))
    elems.append(info_box(
        "INGAT: Soal Matematika TKA bukan hafalan rumus. Kamu akan diminta memodelkan masalah nyata ke "
        "dalam matematika. Latih soal kontekstual (soal cerita), bukan soal hitungan langsung.",
        MERAH_PALE, MERAH
    ))

    return elems

# ── BAB 2: BAHASA INDONESIA ──────────────────────────────────────────────────
def bab_bindo():
    elems = [PageBreak()]
    elems.append(bab_header("2", "BAHASA INDONESIA",
                 "Fokus Membaca Teks • 2 Jenis Teks • 5 Tahap Kompetensi", HIJAU_TUA))
    elems.append(space(14))

    elems.append(Paragraph(
        "Yang diuji <b>bukan hafalan EYD atau jenis teks.</b> Fokusnya adalah kemampuan membaca aktif "
        "dan memahami teks secara mendalam — termasuk makna yang <i>tidak tersurat langsung</i>.",
        S("BPB", fontSize=10.5, fontName="Helvetica", textColor=ABU_TUA, leading=16, alignment=TA_JUSTIFY)
    ))
    elems.append(space(12))

    # 2 Jenis Teks
    elems.append(sub_header("Jenis Teks yang Diujikan", HIJAU_MUDA))
    elems.append(space(8))
    teks_tbl = Table([[
        Paragraph("<b>Teks Informasi</b>", S("TT1", fontSize=10.5, fontName="Helvetica-Bold",
                  textColor=HIJAU_TUA, leading=15)),
        Paragraph("<b>Teks Fiksi</b>", S("TT2", fontSize=10.5, fontName="Helvetica-Bold",
                  textColor=HIJAU_TUA, leading=15)),
    ],[
        Paragraph(
            "Berisi fakta, konsep, atau prosedur dari berbagai bidang/topik berskala lokal, "
            "nasional, atau global. Dapat berupa teks tunggal maupun teks jamak.",
            S("TI1", fontSize=9.5, fontName="Helvetica", textColor=ABU_TUA, leading=14)),
        Paragraph(
            "Cerita rekaan yang dapat bersifat faktual (sejarah/biografi) atau realisme, "
            "dengan latar konkret/abstrak, tokoh berkarakter bulat, konflik tunggal atau jamak.",
            S("TI2", fontSize=9.5, fontName="Helvetica", textColor=ABU_TUA, leading=14)),
    ]],
    colWidths=["50%","50%"])
    teks_tbl.setStyle(TableStyle([
        ("BACKGROUND",    (0,0),(0,0), HIJAU_PALE),
        ("BACKGROUND",    (1,0),(1,0), HIJAU_PALE),
        ("BACKGROUND",    (0,1),(0,1), PUTIH),
        ("BACKGROUND",    (1,1),(1,1), PUTIH),
        ("TOPPADDING",    (0,0),(-1,-1), 10),
        ("BOTTOMPADDING", (0,0),(-1,-1), 10),
        ("LEFTPADDING",   (0,0),(-1,-1), 12),
        ("RIGHTPADDING",  (0,0),(-1,-1), 12),
        ("BOX",           (0,0),(-1,-1), 0.5, colors.HexColor("#82E0AA")),
        ("INNERGRID",     (0,0),(-1,-1), 0.5, colors.HexColor("#82E0AA")),
        ("ROUNDEDCORNERS",(0,0),(-1,-1), [5]),
    ]))
    elems.append(teks_tbl)
    elems.append(space(16))

    # 5 Tahap
    tahap_data = [
        ("TAHAP 1", "Pemahaman Literal", HIJAU_TUA,
         "Menemukan informasi yang secara eksplisit ada di teks.",
         ["Informasi eksplisit", "Fakta langsung dari teks", "Detail teks"],
         ["Siapa?", "Kapan?", "Di mana?", "Apa?"]),
        ("TAHAP 2", "Ide Pokok", HIJAU_TUA,
         "Memahami inti gagasan dari setiap paragraf maupun keseluruhan teks.",
         ["Gagasan utama paragraf", "Kalimat utama", "Topik paragraf", "Ringkasan teks"],
         None),
        ("TAHAP 3", "Inferensi ★ PALING PENTING", MERAH,
         "Kemampuan menyimpulkan informasi yang tidak tertulis langsung — inilah yang paling banyak diukur TKA.",
         ["Kesimpulan", "Makna tersirat", "Tujuan penulis", "Hubungan sebab akibat", "Prediksi"],
         None),
        ("TAHAP 4", "Analisis Teks", HIJAU_TUA,
         "Memahami struktur, argumen, dan jenis teks.",
         ["Struktur teks (eksposisi, argumentasi, deskripsi, narasi, berita, artikel ilmiah populer)",
          "Argumen dan bukti", "Opini"],
         None),
        ("TAHAP 5", "Evaluasi", HIJAU_TUA,
         "Level tertinggi TKA — menilai kualitas dan kekuatan teks.",
         ["Fakta vs Opini", "Kekuatan argumen", "Keakuratan informasi", "Keefektifan teks"],
         None),
    ]

    for kode, nama, warna, desk, materi_list, contoh in tahap_data:
        is_penting = "★" in nama
        bg = MERAH_PALE if is_penting else HIJAU_PALE
        hdr_bg = MERAH if is_penting else HIJAU_MUDA

        t_obj = Table([[
            Paragraph(kode, S("TK", fontSize=9, fontName="Helvetica-Bold",
                      textColor=PUTIH, alignment=TA_CENTER)),
            Paragraph(nama, S("TN", fontSize=11, fontName="Helvetica-Bold",
                      textColor=PUTIH)),
        ]], colWidths=["20%","80%"])
        t_obj.setStyle(TableStyle([
            ("BACKGROUND",    (0,0),(-1,-1), hdr_bg),
            ("TOPPADDING",    (0,0),(-1,-1), 8),
            ("BOTTOMPADDING", (0,0),(-1,-1), 8),
            ("LEFTPADDING",   (0,0),(-1,-1), 12),
            ("ROUNDEDCORNERS",(0,0),(-1,-1), [5]),
        ]))
        elems.append(KeepTogether([t_obj]))
        elems.append(space(4))
        elems.append(Paragraph(desk, S("TKD", fontSize=10, fontName="Helvetica-Oblique",
                    textColor=ABU_TUA, leading=15)))
        elems.append(space(5))
        elems.append(Paragraph("Yang dipelajari:", sH3))
        for m in materi_list:
            elems.append(Paragraph(f"• {m}", sBullet))
        if contoh:
            elems.append(space(4))
            elems.append(Paragraph("Contoh pertanyaan literal:", sInfo))
            elems.append(alur_box(contoh, bg, warna))
        elems.append(space(12))

    # Prioritas BI
    elems.append(PageBreak())
    elems.append(Paragraph("PRIORITAS BELAJAR BAHASA INDONESIA", sH1))
    elems.append(hr(HIJAU_PALE))
    elems.append(space(8))
    elems.append(prioritas_table([
        "Ide Pokok (gagasan utama & kalimat utama)",
        "Kesimpulan",
        "Inferensi (makna tersirat & tujuan penulis)",
        "Fakta vs Opini",
        "Ringkasan teks",
        "Struktur Teks",
    ], HIJAU_MUDA, HIJAU_PALE))
    elems.append(space(12))
    elems.append(info_box(
        "INGAT: Belajar Bahasa Indonesia untuk TKA bukan menghafal jenis teks. Latih membaca aktif: "
        "bedakan informasi utama & tambahan, temukan makna tersirat, dan biasakan membaca teks panjang.",
        MERAH_PALE, MERAH
    ))
    return elems

# ── BAB 3: BAHASA INGGRIS ────────────────────────────────────────────────────
def bab_bing():
    elems = [PageBreak()]
    elems.append(bab_header("3", "BAHASA INGGRIS",
                 "Reading Comprehension • Level A2–B1 CEFR • 5 Jenis Teks", ORANYE_TUA))
    elems.append(space(14))

    elems.append(Paragraph(
        "TKA Bahasa Inggris mengukur kemampuan membaca pada level A2–B1 CEFR. "
        "Artinya: <b>bukan grammar berat, bukan speaking, bukan listening</b>. "
        "Fokus utamanya adalah <b>Reading Comprehension</b>.",
        S("BPI", fontSize=10.5, fontName="Helvetica", textColor=ABU_TUA, leading=16, alignment=TA_JUSTIFY)
    ))
    elems.append(space(10))

    # Level teks
    level_tbl = Table([[
        Paragraph("<b>Level A2</b>", S("LA2", fontSize=10.5, fontName="Helvetica-Bold",
                  textColor=ORANYE_TUA, alignment=TA_CENTER)),
        Paragraph("<b>Level B1</b>", S("LB1", fontSize=10.5, fontName="Helvetica-Bold",
                  textColor=ORANYE_TUA, alignment=TA_CENTER)),
    ],[
        Paragraph(
            "Panjang ~200–300 kata • Kosakata 2.000 kata frekuensi tinggi • "
            "Kalimat sederhana & majemuk dasar • Konteks kehidupan sehari-hari & vokasional.",
            S("LA2D", fontSize=9.5, fontName="Helvetica", textColor=ABU_TUA, leading=14)),
        Paragraph(
            "Panjang ~250–350 kata • Kosakata 3.000 kata frekuensi tinggi • "
            "Kalimat sederhana hingga kompleks • Konteks sehari-hari, vokasional, dan akademik dasar.",
            S("LB1D", fontSize=9.5, fontName="Helvetica", textColor=ABU_TUA, leading=14)),
    ]],
    colWidths=["50%","50%"])
    level_tbl.setStyle(TableStyle([
        ("BACKGROUND",    (0,0),(-1,0), ORANYE_PALE),
        ("BACKGROUND",    (0,1),(-1,1), PUTIH),
        ("TOPPADDING",    (0,0),(-1,-1), 10),
        ("BOTTOMPADDING", (0,0),(-1,-1), 10),
        ("LEFTPADDING",   (0,0),(-1,-1), 12),
        ("RIGHTPADDING",  (0,0),(-1,-1), 12),
        ("BOX",           (0,0),(-1,-1), 0.5, colors.HexColor("#F0B27A")),
        ("INNERGRID",     (0,0),(-1,-1), 0.5, colors.HexColor("#F0B27A")),
    ]))
    elems.append(level_tbl)
    elems.append(space(16))

    # Jenis Teks
    elems.append(sub_header("Jenis Teks yang Diujikan", ORANYE_MED))
    elems.append(space(8))
    jenis = ["Narrative", "Descriptive", "Recount", "Analytical Exposition", "Procedure"]
    jenis_tbl = Table([[Paragraph(j, S("JT", fontSize=10, fontName="Helvetica-Bold",
                       textColor=ORANYE_TUA, alignment=TA_CENTER)) for j in jenis]],
                      colWidths=["20%"]*5)
    jenis_tbl.setStyle(TableStyle([
        ("BACKGROUND",    (0,0),(-1,-1), ORANYE_PALE),
        ("TOPPADDING",    (0,0),(-1,-1), 10),
        ("BOTTOMPADDING", (0,0),(-1,-1), 10),
        ("INNERGRID",     (0,0),(-1,-1), 0.5, colors.HexColor("#F0B27A")),
        ("BOX",           (0,0),(-1,-1), 0.5, colors.HexColor("#F0B27A")),
        ("ROUNDEDCORNERS",(0,0),(-1,-1), [5]),
    ]))
    elems.append(jenis_tbl)
    elems.append(space(16))

    # 5 Tahap
    tahap_bing = [
        ("TAHAP 1", "Vocabulary Dasar", ORANYE_MED,
         "Target minimal: 1.500–2.500 kata umum frekuensi tinggi.",
         ["School & Education", "Technology", "Environment", "Health", "Daily life",
          "Work & Vocational"]),
        ("TAHAP 2", "Grammar Dasar", ORANYE_MED,
         "Grammar dibutuhkan untuk memahami makna kalimat, bukan untuk diujikan secara langsung.",
         ["Simple Present & Simple Past", "Present Continuous", "Present Perfect",
          "Passive Voice dasar", "Modal Verbs", "Conditional Sentences dasar"]),
        ("TAHAP 3", "Reading Comprehension", ORANYE_MED,
         "Inti dari TKA Bahasa Inggris. Belajar memahami teks secara menyeluruh.",
         ["Main idea (gagasan utama)", "Supporting details", "Reference (pronoun & referensi kata)",
          "Vocabulary in context (makna kata dari konteks)", "Purpose of paragraph/text"]),
        ("TAHAP 4", "Inferential Reading ★ TERSULIT", MERAH,
         "Bagian paling sulit — harus memahami seluruh teks, bukan hanya satu paragraf.",
         ["Author's purpose (tujuan penulis)", "Tone & mood", "Inference (kesimpulan tersirat)",
          "Conclusion", "Implication"]),
        ("TAHAP 5", "Critical Reading", ORANYE_MED,
         "Level evaluasi: menilai kualitas dan kekuatan teks.",
         ["Fact vs Opinion", "Bias dalam teks", "Argument Strength", "Evidence & Support"]),
    ]

    for kode, nama, warna, desk, materi_list in tahap_bing:
        is_penting = "★" in nama
        hdr_bg = MERAH if is_penting else ORANYE_MED

        t_obj = Table([[
            Paragraph(kode, S("TKE", fontSize=9, fontName="Helvetica-Bold",
                      textColor=PUTIH, alignment=TA_CENTER)),
            Paragraph(nama, S("TNE", fontSize=11, fontName="Helvetica-Bold",
                      textColor=PUTIH)),
        ]], colWidths=["22%","78%"])
        t_obj.setStyle(TableStyle([
            ("BACKGROUND",    (0,0),(-1,-1), hdr_bg),
            ("TOPPADDING",    (0,0),(-1,-1), 8),
            ("BOTTOMPADDING", (0,0),(-1,-1), 8),
            ("LEFTPADDING",   (0,0),(-1,-1), 12),
            ("ROUNDEDCORNERS",(0,0),(-1,-1), [5]),
        ]))
        elems.append(KeepTogether([t_obj]))
        elems.append(space(4))
        elems.append(Paragraph(desk, S("TKDE", fontSize=10, fontName="Helvetica-Oblique",
                    textColor=ABU_TUA, leading=15)))
        elems.append(space(5))
        elems.append(Paragraph("Yang dipelajari:", sH3))
        for m in materi_list:
            elems.append(Paragraph(f"• {m}", sBullet))
        elems.append(space(12))

    # Prioritas Bahasa Inggris
    elems.append(PageBreak())
    elems.append(Paragraph("PRIORITAS BELAJAR BAHASA INGGRIS", sH1))
    elems.append(hr(ORANYE_PALE))
    elems.append(space(8))
    elems.append(prioritas_table([
        "Vocabulary (kosakata frekuensi tinggi 1.500–2.500 kata)",
        "Reading Comprehension (main idea & supporting details)",
        "Main Idea & Purpose of text",
        "Inference (makna tersirat & tujuan penulis)",
        "Grammar Dasar (tenses, passive voice, modals)",
        "Critical Reading (fact vs opinion, bias)",
    ], ORANYE_MED, ORANYE_PALE))
    elems.append(space(12))
    elems.append(info_box(
        "INGAT: TKA Bahasa Inggris adalah tes membaca, bukan tes grammar murni. "
        "Tapi grammar yang lemah bikin banyak salah tafsir makna kalimat. "
        "Kuasai dulu kosakata frekuensi tinggi, lalu latih membaca teks descriptive & exposition.",
        MERAH_PALE, MERAH
    ))
    return elems

# ── BAB 4: JADWAL BELAJAR ────────────────────────────────────────────────────
def bab_jadwal():
    elems = [PageBreak()]
    elems.append(bab_header("4", "JADWAL BELAJAR 4 BULAN",
                 "Juni → Oktober 2026 • Kelas 11 RPL → TKA", BIRU_TUA))
    elems.append(space(14))

    elems.append(Paragraph(
        "Kamu memiliki sekitar 4 bulan dari Juni hingga akhir Oktober. Jadwal ini dirancang agar "
        "kamu <b>tidak belajar semua mapel sekaligus</b>, melainkan fokus per blok bulan sehingga "
        "pemahaman lebih dalam.",
        S("JDB", fontSize=10.5, fontName="Helvetica", textColor=ABU_TUA, leading=16, alignment=TA_JUSTIFY)
    ))
    elems.append(space(14))

    periode = [
        ("PERIODE 1", "Juni – Juli", BIRU_TUA,
         [("Matematika", BIRU_PALE, BIRU_TUA, [
             "Bilangan (bulat, pecahan, persentase, rasio)",
             "Aljabar (variabel, operasi, persamaan linear)",
             "Fungsi (domain, kodomain, grafik)",
             "Pertidaksamaan & SPLDV",
         ]),
          ("Bahasa Indonesia", HIJAU_PALE, HIJAU_TUA, [
              "Ide pokok & kalimat utama",
              "Ringkasan teks",
              "Struktur teks dasar",
          ]),
          ("Bahasa Inggris", ORANYE_PALE, ORANYE_TUA, [
              "Vocabulary frekuensi tinggi (500 kata pertama)",
              "Grammar dasar: Simple Present, Simple Past",
          ])
         ]),
        ("PERIODE 2", "Agustus", HIJAU_TUA,
         [("Matematika", BIRU_PALE, BIRU_TUA, [
             "Geometri (bangun datar & ruang, Pythagoras)",
             "Trigonometri (sin, cos, tan, sudut istimewa)",
         ]),
          ("Bahasa Indonesia", HIJAU_PALE, HIJAU_TUA, [
              "Inferensi (makna tersirat)",
              "Kesimpulan dari teks",
          ]),
          ("Bahasa Inggris", ORANYE_PALE, ORANYE_TUA, [
              "Reading Comprehension (narrative, descriptive)",
              "Vocabulary lanjutan (500 kata berikutnya)",
          ])
         ]),
        ("PERIODE 3", "September", ORANYE_TUA,
         [("Matematika", BIRU_PALE, BIRU_TUA, [
             "Data dan Peluang (mean, median, modus, diagram)",
             "Barisan & Deret, Matriks",
         ]),
          ("Bahasa Indonesia", HIJAU_PALE, HIJAU_TUA, [
              "Evaluasi teks (fakta vs opini)",
              "Analisis argumen & tujuan penulis",
          ]),
          ("Bahasa Inggris", ORANYE_PALE, ORANYE_TUA, [
              "Inferential Reading",
              "Critical Reading (fact vs opinion, analytical exposition)",
          ])
         ]),
        ("PERIODE 4", "Oktober (H-3 Minggu)", MERAH,
         [("Semua Mapel", MERAH_PALE, MERAH, [
             "Latihan soal TKA penuh (semua materi)",
             "Tryout simulasi TKA",
             "Analisis kesalahan — cari pola soal yang sering salah",
             "Perbaiki kelemahan spesifik",
             "Review materi-materi yang masih lemah",
         ])
         ]),
    ]

    for kode, bulan, warna, mapel_list in periode:
        hdr = Table([[
            Paragraph(kode, S("PK", fontSize=9, fontName="Helvetica-Bold",
                      textColor=PUTIH, alignment=TA_CENTER)),
            Paragraph(bulan, S("PB3", fontSize=13, fontName="Helvetica-Bold",
                      textColor=PUTIH)),
        ]], colWidths=["25%","75%"])
        hdr.setStyle(TableStyle([
            ("BACKGROUND",    (0,0),(-1,-1), warna),
            ("TOPPADDING",    (0,0),(-1,-1), 10),
            ("BOTTOMPADDING", (0,0),(-1,-1), 10),
            ("LEFTPADDING",   (0,0),(-1,-1), 14),
            ("ROUNDEDCORNERS",(0,0),(-1,-1), [6]),
        ]))
        elems.append(hdr)
        elems.append(space(8))

        for nama_mapel, bg, fg, fokus_list in mapel_list:
            elems.append(Paragraph(f"  {nama_mapel}:", S("NM", fontSize=10, fontName="Helvetica-Bold",
                         textColor=fg, spaceBefore=4, spaceAfter=2)))
            for f in fokus_list:
                elems.append(Paragraph(f"    → {f}", S("FL", fontSize=9.5, fontName="Helvetica",
                             textColor=ABU_TUA, leftIndent=20, spaceBefore=1, spaceAfter=1, leading=14)))
        elems.append(space(14))

    # Tips akhir
    elems.append(PageBreak())
    elems.append(Paragraph("TIPS BELAJAR EFEKTIF TKA", sH1))
    elems.append(hr(BIRU_PALE))
    elems.append(space(10))

    tips = [
        ("Latihan Soal > Membaca Teori",
         "Baca materi secukupnya, lalu langsung kerjakan soal. TKA menguji penerapan, bukan hafalan."),
        ("Analisis Kesalahan",
         "Setiap latihan soal, catat soal yang salah dan pahami MENGAPA jawabanmu salah."),
        ("Sumber Gratis yang Bisa Dipakai",
         "Pusmendik.kemendikdasmen.go.id (simulasi resmi) • Zenius.net • Ruangguru • Khan Academy (untuk materi)."),
        ("Jangan Belajar Semua Sekaligus",
         "Ikuti periodisasi di Bab 4. Belajar satu topik tuntas jauh lebih baik daripada belajar semua setengah-setengah."),
        ("Biasakan Membaca Teks Panjang",
         "Untuk BI dan B.Inggris, latih membaca artikel berita atau esai setiap hari. Ini melatih stamina membaca soal TKA."),
        ("Perhatikan Konteks di Matematika",
         "Soal Matematika TKA hampir selalu berupa soal cerita. Latih identifikasi apa yang ditanya dan apa yang diketahui."),
    ]

    for judul_tip, isi_tip in tips:
        t = Table([[
            Paragraph(f"<b>{judul_tip}</b>", S("TJ2", fontSize=10.5, fontName="Helvetica-Bold",
                      textColor=BIRU_TUA, leading=15)),
        ],[
            Paragraph(isi_tip, S("TI3", fontSize=10, fontName="Helvetica",
                      textColor=ABU_TUA, leading=15)),
        ]], colWidths=[A4[0]-4*cm])
        t.setStyle(TableStyle([
            ("BACKGROUND",    (0,0),(0,0), BIRU_PALE),
            ("BACKGROUND",    (0,1),(0,1), PUTIH),
            ("TOPPADDING",    (0,0),(0,0), 8),
            ("BOTTOMPADDING", (0,0),(0,0), 6),
            ("TOPPADDING",    (0,1),(0,1), 6),
            ("BOTTOMPADDING", (0,1),(0,1), 8),
            ("LEFTPADDING",   (0,0),(-1,-1), 14),
            ("RIGHTPADDING",  (0,0),(-1,-1), 14),
            ("BOX",           (0,0),(0,-1), 0.5, colors.HexColor("#B2CEED")),
            ("ROUNDEDCORNERS",(0,0),(0,-1), [5]),
        ]))
        elems.append(t)
        elems.append(space(10))

    return elems

# ── HALAMAN FOOTER ────────────────────────────────────────────────────────────
# ── HALAMAN FOOTER ────────────────────────────────────────────────────────────
def footer_page(canvas, doc):
    canvas.saveState()
    canvas.setFont("Helvetica", 8)
    canvas.setFillColor(ABU_MUDA)
    canvas.drawString(2*cm, 1.2*cm, "Panduan Belajar TKA SMK 2026 — Matematika · Bahasa Indonesia · Bahasa Inggris")
    canvas.drawRightString(A4[0]-2*cm, 1.2*cm, f"Halaman {doc.page}")
    canvas.setStrokeColor(ABU_PALE)
    canvas.line(2*cm, 1.5*cm, A4[0]-2*cm, 1.5*cm)
    canvas.restoreState()


# tuty
# tuty
# tuty
# tuty
# tuty
# tuty
# tuty
# tuty
# tuty
# tuty
# tuty
# tuty
# tuty
# tuty
# ── BUILD PDF ────────────────────────────────────────────────────────────────
output_path = "Panduan_Belajar_TKA_SMK_2026.pdf"
doc = SimpleDocTemplate(
    output_path,
    pagesize=A4,
    rightMargin=2*cm, leftMargin=2*cm,
    topMargin=2*cm,   bottomMargin=2.5*cm,
    title="Panduan Belajar TKA SMK 2026",
    author="Disusun berdasarkan kisi-kisi resmi Pusmendik",
    subject="Matematika, Bahasa Indonesia, Bahasa Inggris",
)

story = []
story += cover_page()
story += bab_matematika()
story += bab_bindo()
story += bab_bing()
story += bab_jadwal()

doc.build(story, onFirstPage=footer_page, onLaterPages=footer_page)
print("PDF berhasil dibuat:", output_path)


# p
# p
# p
# p
# p
# p
# p
# p
# p
# p
# p