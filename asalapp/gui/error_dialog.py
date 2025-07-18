from PyQt6.QtWidgets import QDialog, QVBoxLayout, QLabel, QTextEdit, QPushButton, QDialogButtonBox, QApplication, QMessageBox
from PyQt6.QtGui import QTextCursor
from PyQt6.QtWidgets import QSizePolicy

class ErrorDialog(QDialog):
    def __init__(self, error_message, traceback_text, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Terjadi Kesalahan")
        self.setModal(True)
        self.error_message_text = error_message
        self.traceback_text_content = traceback_text

        layout = QVBoxLayout(self)

        self.label_error = QLabel(f"Mohon maaf, terjadi kesalahan pada aplikasi.\n{self.error_message_text}")
        self.label_error.setWordWrap(True)
        layout.addWidget(self.label_error)

        self.details_area = QTextEdit()
        self.details_area.setReadOnly(True)
        self.details_area.setText(self.traceback_text_content)
        self.details_area.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Expanding)
        layout.addWidget(self.details_area)

        self.button_box = QDialogButtonBox()
        self.button_copy = QPushButton("Salin Debug")
        self.button_copy.clicked.connect(self.copy_traceback)
        self.button_box.addButton(self.button_copy, QDialogButtonBox.ButtonRole.ActionRole)

        self.button_ok = QPushButton("OK")
        self.button_ok.clicked.connect(self.accept)
        self.button_box.addButton(self.button_ok, QDialogButtonBox.ButtonRole.AcceptRole)

        layout.addWidget(self.button_box)
        self.setLayout(layout)
        self.resize(500, 400)

    def copy_traceback(self):
        clipboard = QApplication.clipboard()
        clipboard.setText(self.traceback_text_content)
        QMessageBox.information(self, "Disalin", "Informasi debug telah disalin ke clipboard.")