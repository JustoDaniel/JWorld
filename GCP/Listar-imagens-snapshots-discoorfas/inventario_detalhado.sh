#!/bin/bash

INPUT_FILE="projetos.csv"

if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Erro: Arquivo $INPUT_FILE não encontrado!"
    exit 1
fi

echo "Projeto,Tipo,Nome_Objeto,Data_Criacao"

while IFS= read -r PROJECT_ID || [[ -n "$PROJECT_ID" ]]; do
    PROJECT_ID=$(echo "$PROJECT_ID" | tr -d '\r' | xargs)
    [ -z "$PROJECT_ID" ] && continue

    # 1. Machine Images (Removido espaços internos e ajustado aspas)
    gcloud compute machine-images list --project="$PROJECT_ID" --format='csv[no-heading](project().scope(), "MachineImage", name, creationTimestamp)' 2>/dev/null

    # 2. Snapshots
    gcloud compute snapshots list --project="$PROJECT_ID" --format='csv[no-heading](project().scope(), "Snapshot", name, creationTimestamp)' 2>/dev/null

    # 3. Discos Órfãos (Filtro ajustado para maior compatibilidade)
    gcloud compute disks list --project="$PROJECT_ID" --filter="-users:*" --format='csv[no-heading](project().scope(), "Disco_Orfao", name, creationTimestamp)' 2>/dev/null

done < "$INPUT_FILE"