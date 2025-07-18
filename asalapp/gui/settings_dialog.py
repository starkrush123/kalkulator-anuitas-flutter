from PyQt6.QtWidgets import QDialog, QVBoxLayout, QFormLayout, QGroupBox, QRadioButton, QLabel, QComboBox, QDialogButtonBox

class SettingsDialog(QDialog):
    def __init__(self, parent=None, current_font_size=12, current_mode_rumus="biasa", current_theme="Ikuti Sistem"):
        super().__init__(parent)
        self.setWindowTitle("Pengaturan")
        self.setModal(True)

        self.current_font_size = current_font_size
        self.current_mode_rumus = current_mode_rumus
        self.current_theme = current_theme

        layout = QVBoxLayout(self)
        form_layout = QFormLayout()

        self.mode_rumus_group = QGroupBox("Mode Rumus")
        mode_layout = QVBoxLayout()
        self.radio_biasa = QRadioButton("Anuitas Biasa")
        self.radio_awal_periode = QRadioButton("Anuitas di Awal Periode")
        if self.current_mode_rumus == "biasa":
            self.radio_biasa.setChecked(True)
        else:
            self.radio_awal_periode.setChecked(True)
        mode_layout.addWidget(self.radio_biasa)
        mode_layout.addWidget(self.radio_awal_periode)
        self.mode_rumus_group.setLayout(mode_layout)
        form_layout.addRow(self.mode_rumus_group)

        self.label_font_size = QLabel("Pilih Ukuran Teks:")
        self.combo_font_size = QComboBox()
        self.combo_font_size.addItems([str(i) for i in range(8, 25, 2)])
        self.combo_font_size.setCurrentText(str(self.current_font_size))
        form_layout.addRow(self.label_font_size, self.combo_font_size)

        self.label_theme = QLabel("Mode Tampilan:")
        self.combo_theme = QComboBox()
        self.combo_theme.addItems(["Terang", "Gelap", "Ikuti Sistem"])
        self.combo_theme.setCurrentText(self.current_theme)
        form_layout.addRow(self.label_theme, self.combo_theme)

        layout.addLayout(form_layout)

        self.button_box = QDialogButtonBox(QDialogButtonBox.StandardButton.Save | QDialogButtonBox.StandardButton.Cancel)
        self.button_box.accepted.connect(self.accept)
        self.button_box.rejected.connect(self.reject)
        layout.addWidget(self.button_box)
        self.setLayout(layout)

    def get_settings(self):
        font_size = int(self.combo_font_size.currentText())
        theme = self.combo_theme.currentText()
        mode_rumus = "biasa" if self.radio_biasa.isChecked() else "awal_periode"
        return font_size, mode_rumus, theme