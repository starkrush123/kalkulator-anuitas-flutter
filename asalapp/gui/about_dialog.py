from PyQt6.QtWidgets import QDialog, QVBoxLayout, QTextEdit, QDialogButtonBox
from PyQt6.QtCore import Qt
from PyQt6.QtGui import PYQT_VERSION_STR

class AboutDialog(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Tentang Kalkulator Anuitas")
        self.setModal(True)

        layout = QVBoxLayout(self)

        about_text_content = (
            f"<p><b>Kalkulator Anuitas</b></p>"
            f"<p>Dibuat oleh: Ridho</p>"
            f"<p>GUI Interface: Qt</p>"
            f"<p>Versi PyQt: {PYQT_VERSION_STR}</p>"
            f"<p>Dibuat dengan Python dan Qt.</p>"
        )

        self.text_area = QTextEdit()
        self.text_area.setReadOnly(True)
        self.text_area.setHtml(about_text_content)
        self.text_area.setFocusPolicy(Qt.FocusPolicy.StrongFocus)

        layout.addWidget(self.text_area)

        self.button_box = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok)
        self.button_box.accepted.connect(self.accept)

        layout.addWidget(self.button_box)
        self.setLayout(layout)
        self.resize(350, 250)