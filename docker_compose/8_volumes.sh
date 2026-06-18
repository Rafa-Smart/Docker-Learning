services:
  # Kumpulan service/container yang akan dibuat oleh Docker Compose

  backend:
    # Nama service
    # Docker Compose akan membuat container untuk service ini

    image: example/backend
    # Image yang akan digunakan untuk membuat container
    # Format:
    # image: nama-image:tag
    #
    # contoh:
    # nginx:latest
    # mysql:8
    # node:22
    #
    # pada contoh ini:
    # example/backend adalah image yang akan dijalankan

    volumes:
      # Daftar mount yang akan dipasang ke container
      #
      # Volume digunakan agar:
      # - data tidak hilang
      # - container bisa mengakses file host
      # - sharing data antar container

      - type: volume
        # Jenis mount
        #
        # Ada beberapa tipe:
        # volume = dikelola Docker
        # bind   = folder/file langsung dari host
        # tmpfs  = disimpan di memory

        source: db-data
        # Nama volume yang akan digunakan
        #
        # Volume ini harus ada di bagian:
        #
        # volumes:
        #   db-data:
        # yang ada di abwah ya
        #
        # Docker akan membuat volume bernama db-data

        target: /data
        # Lokasi di dalam container
        #
        # Artinya:
        #
        # volume db-data
        #        ↓
        # container:/data

        volume:
          # Konfigurasi khusus untuk type: volume

          nocopy: true
          # Secara default:
          #
          # jika /data di image sudah berisi file,
          # Docker akan menyalin file tersebut ke volume
          #
          # nocopy: true
          # berarti:
          #
          # JANGAN copy isi awal dari image
        #   jadi nntti aja di copy nya pas udha ad adta baru jaid buakn data defual tynag ada di databasenya
          #
          # Biasanya digunakan untuk database

          subpath: sub
          # Hanya mount sub-folder tertentu dari volume
          #
          # Misalnya isi volume:
          #
          # db-data
          # ├── backup
          # ├── logs
          # └── sub
          #
          # Maka yang dipasang ke /data
          # hanya folder "sub"

      - type: bind
        # Bind mount
        #
        # Artinya mengambil file/folder langsung
        # dari komputer host

        source: /var/run/postgres/postgres.sock
        # Lokasi file di HOST
        #
        # HOST:
        # /var/run/postgres/postgres.sock

        target: /var/run/postgres/postgres.sock
        # Lokasi file di CONTAINER
        #
        # CONTAINER:
        # /var/run/postgres/postgres.sock
        #
        # Jadi file host akan muncul
        # pada lokasi ini di dalam container

volumes:
  # Daftar named volume

  db-data:
    # Nama volume
    #
    # Docker akan membuat volume:
    # db-data
    #
    # Biasanya tersimpan di:
    #
    # Linux:
    # /var/lib/docker/volumes/
    #
    # Windows Docker Desktop:
    # berada di dalam VM Docker