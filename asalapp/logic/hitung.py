def hitung_anuitas_biasa(M, i, N):
    if (1 - (1 + i) ** -N) == 0: 
        return M / N if N != 0 else float('inf') 
    A = (i / (1 - (1 + i) ** -N)) * M
    return A

def hitung_anuitas_awal_periode(M, i, N):
    if (1 - (1 + i) ** -N) == 0: 
        return (M / N if N != 0 else float('inf'))
    A = (i / (1 - (1 + i) ** -N)) * M * (1 + i) 
    return A

def hitung_angsuran_pokok(A, i, sisa_pinjaman_sebelumnya):
    bunga = sisa_pinjaman_sebelumnya * i
    pokok = A - bunga
    return pokok

def hitung_bunga_angsuran(sisa_pinjaman_sebelumnya, i):
    return sisa_pinjaman_sebelumnya * i

def hitung_sisa_pinjaman_setelah_angsuran_ke_k(M, i, N, k, tipe_anuitas="biasa"):
    from .hitung import hitung_anuitas_biasa, hitung_anuitas_awal_periode
    if tipe_anuitas == "biasa":
        A = hitung_anuitas_biasa(M, i, N)
    else:
        A = hitung_anuitas_awal_periode(M, i, N)

    if A == float('inf'):
        return M

    sisa_pinjaman = M
    for _ in range(1, k + 1):
        bunga = sisa_pinjaman * i
        pokok = A - bunga
        if pokok < 0 and abs(pokok) < 1e-9:
            pokok = 0
        if pokok < 0:
            return 0
        sisa_pinjaman -= pokok
        if sisa_pinjaman < 0 and abs(sisa_pinjaman) < 1e-9:
            sisa_pinjaman = 0
        if sisa_pinjaman < 0:
            return 0
    return sisa_pinjaman