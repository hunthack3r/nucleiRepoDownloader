#!/bin/bash

# Kullanıcıdan dosya adını al
read -e -p "Repository listesinin bulunduğu dosyanın ismini girin: " filename

# Dosyanın var olup olmadığını kontrol et
if [ ! -f "$filename" ]; then
    echo "Dosya bulunamadı. Lütfen geçerli bir dosya adı girin."
    exit 1
fi

# Dosyadaki her satırı oku
while IFS= read -r repo; do
    # repo adını yazdır
    echo "Cloning $repo..."
    
    # 30 saniye içinde klonlama işlemini gerçekleştir, yoksa iptal et
    timeout 30s git clone "$repo"

    # Hata durumu kontrolü
    if [ $? -ne 0 ]; then
        echo "Failed to clone $repo, moving to the next one."
    else
        echo "$repo cloned successfully."
    fi

done < "$filename"
