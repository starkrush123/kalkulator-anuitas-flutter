import sys
import os
import configparser
import traceback

from PyQt6.QtWidgets import (
    QApplication, QWidget, QVBoxLayout, QHBoxLayout, QLabel, QLineEdit,
    QPushButton, QTextEdit, QComboBox, QFormLayout, QMessageBox
)
from PyQt6.QtCore import Qt
from PyQt6.QtGui import QFont, QPalette, QColor, QDoubleValidator, QIntValidator, QTextCursor

from gui.about_dialog import AboutDialog
from gui.error_dialog import ErrorDialog
from gui.settings_dialog import SettingsDialog
from logic.hitung import (
    hitung_anuitas_biasa, hitung_anuitas_awal_periode,
    hitung_angsuran_pokok, hitung_bunga_angsuran,
    hitung_sisa_pinjaman_setelah_angsuran_ke_k
)

class AnuitasApp(QWidget):
    def __init__(self):
        super().__init__()
        self.config_file_name = "anuitas_settings.ini"
        self.load_settings()
        self.init_ui()
        self.apply_theme()

    def get_config_path(self):
        app_data_path = os.getenv('APPDATA') or os.getenv('XDG_CONFIG_HOME') or os.path.join(os.path.expanduser("~"), ".config")
        app_config_dir = os.path.join(app_data_path, "AnuitasAppPyQt")
        os.makedirs(app_config_dir, exist_ok=True)
        return os.path.join(app_config_dir, self.config_file_name)

    def load_settings(self):
        self.font_size = 12
        self.mode_rumus = "biasa"
        self.theme = "Ikuti Sistem"

        config_path = self.get_config_path()
        if not os.path.exists(config_path):
            self.save_settings()
            return

        config = configparser.ConfigParser()
        try:
            config.read(config_path)
            if 'Settings' in config:
                self.font_size = int(config['Settings'].get('font_size', '12'))
                self.mode_rumus = config['Settings'].get('mode_rumus', 'biasa')
                self.theme = config['Settings'].get('theme', 'Ikuti Sistem')
        except:
            self.save_settings()

    def save_settings(self):
        config = configparser.ConfigParser()
        config['Settings'] = {
            'font_size': str(self.font_size),
            'mode_rumus': self.mode_rumus,
            'theme': self.theme
        }
        with open(self.get_config_path(), 'w') as configfile:
            config.write(configfile)

    def init_ui(self):
        self.setWindowTitle("Kalkulator Anuitas")
        self.resize(500, 500)

        main_layout = QVBoxLayout(self)
        form_layout = QFormLayout()

        self.label_pinjaman = QLabel("Total Pinjaman (Rp):")
        self.input_pinjaman = QLineEdit()
        self.input_pinjaman.setValidator(QDoubleValidator(0, 1e12, 2, self))
        form_layout.addRow(self.label_pinjaman, self.input_pinjaman)

        self.label_bunga = QLabel("Bunga per Periode (%):")
        self.input_bunga = QLineEdit()
        self.input_bunga.setValidator(QDoubleValidator(0, 100, 4, self))
        form_layout.addRow(self.label_bunga, self.input_bunga)

        self.label_periode = QLabel("Jumlah Periode:")
        self.input_periode = QLineEdit()
        self.input_periode.setValidator(QIntValidator(1, 1000, self))
        form_layout.addRow(self.label_periode, self.input_periode)

        self.label_angsuran_ke = QLabel("Detail Angsuran ke- (opsional):")
        self.input_angsuran_ke = QLineEdit()
        self.input_angsuran_ke.setValidator(QIntValidator(1, 1000, self))
        form_layout.addRow(self.label_angsuran_ke, self.input_angsuran_ke)

        main_layout.addLayout(form_layout)

        self.button_hitung = QPushButton("Hitung Anuitas")
        self.button_hitung.clicked.connect(self.on_hitung)
        main_layout.addWidget(self.button_hitung)

        self.output_hasil = QTextEdit()
        self.output_hasil.setReadOnly(True)
        main_layout.addWidget(self.output_hasil, 1)

        self.button_settings = QPushButton("Pengaturan")
        self.button_settings.clicked.connect(self.on_settings)

        self.button_about = QPushButton("Tentang")
        self.button_about.clicked.connect(self.on_about)

        button_layout = QHBoxLayout()
        button_layout.addWidget(self.button_settings)
        button_layout.addWidget(self.button_about)
        main_layout.addLayout(button_layout)

        self.apply_font_size()

    def apply_font_size(self):
        font = QFont()
        font.setPointSize(self.font_size)
        self.setFont(font)

    def apply_theme(self):
        app = QApplication.instance()
        if self.theme == "Gelap":
            palette = QPalette()
            palette.setColor(QPalette.ColorRole.Window, QColor("#2b2b2b"))
            palette.setColor(QPalette.ColorRole.WindowText, Qt.GlobalColor.white)
            app.setPalette(palette)
        else:
            app.setPalette(QPalette())

    def on_hitung(self):
        try:
            M = float(self.input_pinjaman.text())
            i = float(self.input_bunga.text()) / 100.0
            N = int(self.input_periode.text())
            k = int(self.input_angsuran_ke.text()) if self.input_angsuran_ke.text() else None

            A = hitung_anuitas_biasa(M, i, N) if self.mode_rumus == "biasa" else hitung_anuitas_awal_periode(M, i, N)

            hasil_text = f"Anuitas: Rp {A:,.2f}\n"
            if k:
                sisa_sebelum = M if k == 1 else hitung_sisa_pinjaman_setelah_angsuran_ke_k(M, i, N, k - 1, self.mode_rumus)
                bunga_k = hitung_bunga_angsuran(sisa_sebelum, i)
                pokok_k = A - bunga_k
                sisa_setelah = sisa_sebelum - pokok_k
                hasil_text += f"Angsuran ke-{k}: Pokok Rp {pokok_k:,.2f}, Bunga Rp {bunga_k:,.2f}, Sisa Rp {sisa_setelah:,.2f}"

            self.output_hasil.setText(hasil_text)
            self.output_hasil.moveCursor(QTextCursor.MoveOperation.Start)

        except Exception as e:
            traceback_text = traceback.format_exc()
            dlg = ErrorDialog(str(e), traceback_text)
            dlg.exec()

    def on_settings(self):
        dlg = SettingsDialog(self, self.font_size, self.mode_rumus, self.theme)
        if dlg.exec():
            self.font_size, self.mode_rumus, self.theme = dlg.get_settings()
            self.apply_font_size()
            self.apply_theme()
            self.save_settings()

    def on_about(self):
        dlg = AboutDialog(self)
        dlg.exec()

def global_exception_hook(exctype, value, tb):
    traceback_details = "".join(traceback.format_exception(exctype, value, tb))
    error_message_user = f"Tipe Error: {exctype.__name__}\nPesan: {value}"
    if QApplication.instance():
        dialog = ErrorDialog(error_message_user, traceback_details)
        dialog.exec()
    else:
        print(error_message_user)
        print(traceback_details)

def main():
    sys.excepthook = global_exception_hook
    app = QApplication(sys.argv)
    app.setApplicationName("Kalkulator Anuitas")
    ex = AnuitasApp()
    ex.show()
    sys.exit(app.exec())

if __name__ == '__main__':
    main()