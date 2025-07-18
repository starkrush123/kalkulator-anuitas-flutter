double hitungAnuitasBiasa(double M, double i, int N) {
  if (N == 0) return M;
  if (i == 0) return M / N;

  double pembilang = i;
  double penyebut = (1 - (1 + i) * -N);

  if (penyebut == 0) {
    return double.infinity;
  }
  return (pembilang / penyebut) * M;
}

double hitungAnuitasAwalPeriode(double M, double i, int N) {
  if (N == 0) return M;
  if (i == 0) return M / N;

  double pembilang = i;
  double penyebut = (1 - (1 + i) * -N);

  if (penyebut == 0) {
    return double.infinity;
  }
  return (pembilang / penyebut) * M * (1 + i);
}

double hitungAngsuranPokok(double A, double i, double sisaPinjamanSebelumnya) {
  double bunga = sisaPinjamanSebelumnya * i;
  return A - bunga;
}

double hitungBungaAngsuran(double sisaPinjamanSebelumnya, double i) {
  return sisaPinjamanSebelumnya * i;
}

double hitungSisaPinjamanSetelahAngsuranKeK(
    double M, double i, int N, int k, String tipeAnuitas) {
  double A;
  if (tipeAnuitas == "biasa") {
    A = hitungAnuitasBiasa(M, i, N);
  } else {
    A = hitungAnuitasAwalPeriode(M, i, N);
  }

  if (A.isInfinite) {
    return M;
  }

  double sisaPinjaman = M;
  for (int periode = 1; periode <= k; periode++) {
    double bunga = sisaPinjaman * i;
    double pokok = A - bunga;

    if (pokok < 0 && pokok.abs() < 1e-9) {
      pokok = 0;
    }
    if (pokok < 0) {
      return 0;
    }

    sisaPinjaman -= pokok;

    if (sisaPinjaman < 0 && sisaPinjaman.abs() < 1e-9) {
      sisaPinjaman = 0;
    }
    if (sisaPinjaman < 0) {
      return 0;
    }
  }
  return sisaPinjaman;
}