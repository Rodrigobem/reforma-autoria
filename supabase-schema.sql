-- ══════════════════════════════════════════════════════════════════
--  PROJETO REFORMA AUTORIA — Schema Supabase
--  Execute este arquivo no SQL Editor do seu projeto Supabase
-- ══════════════════════════════════════════════════════════════════

-- Tabela de lançamentos (comprovantes)
create table if not exists reforma_transacoes (
  id            text          primary key,
  data          text,
  descricao     text          not null,
  fornecedor    text,
  segmento      text,
  centro        text,
  forma         text,
  valor_total   numeric(12,2) default 0,
  parcelas      integer       default 1,
  valor_parcela numeric(12,2) default 0,
  total_pago    numeric(12,2) default 0,
  status        text          default 'Pago à Vista',
  obs           text,
  created_at    timestamptz   default now()
);

-- Tabela de configurações (orçamento, etc.)
create table if not exists reforma_config (
  chave text primary key,
  valor text
);

-- Desabilitar RLS (projeto privado entre Rodrigo e Daniela)
alter table reforma_transacoes disable row level security;
alter table reforma_config     disable row level security;

-- ──────────────────────────────────────────────────────────────────
-- Primeiro lançamento: Entrada da Marcenaria Castrinho
-- ──────────────────────────────────────────────────────────────────
insert into reforma_transacoes (
  id, data, descricao, fornecedor, segmento, centro,
  forma, valor_total, parcelas, valor_parcela, total_pago,
  status, obs, created_at
) values (
  'seed-1',
  '19/05/2026',
  'Marcenaria Lavabo + Móvel Área Gourmet — Entrada 50%',
  'Marcenaria Castrinho',
  'Marcenaria / Móveis Planejados',
  'Lavabo',
  'Pix',
  2660.00,
  1,
  1330.00,
  1330.00,
  'Parcelado em Andamento',
  'Entrada 50% paga em 19/05/2026 via Pix. Total contrato: R$ 2.660,00. Saldo: R$ 1.330,00. Ctrl: E60746948202605191552A3487qOU18Q',
  '2026-05-19T12:52:37Z'
)
on conflict (id) do nothing;

-- ──────────────────────────────────────────────────────────────────
-- Segundo lançamento: Pedreiro Área Gourmet
-- ──────────────────────────────────────────────────────────────────
insert into reforma_transacoes (
  id, data, descricao, fornecedor, segmento, centro,
  forma, valor_total, parcelas, valor_parcela, total_pago,
  status, obs, created_at
) values (
  'seed-2',
  '21/05/2026',
  'Serviço de Pedreiro — Área Gourmet',
  '',
  'Mão de Obra Geral',
  'Área Gourmet',
  'Pix',
  500.00,
  1,
  500.00,
  500.00,
  'Pago à Vista',
  'Pagamento integral do serviço de pedreiro — Área Gourmet',
  '2026-05-21T00:00:00Z'
)
on conflict (id) do nothing;

-- ──────────────────────────────────────────────────────────────────
-- Terceiro lançamento: Ar-Condicionado + Teto da Garagem
-- ──────────────────────────────────────────────────────────────────
insert into reforma_transacoes (
  id, data, descricao, fornecedor, segmento, centro,
  forma, valor_total, parcelas, valor_parcela, total_pago,
  status, obs, created_at
) values (
  'seed-3',
  '25/05/2026',
  'Estação de Ar-Condicionado + Teto da Garagem',
  'Thiago Ramos Mora',
  'Ar-Condicionado / Climatização',
  'Garagem',
  'Cartão de Crédito',
  3450.00,
  1,
  862.50,
  862.50,
  'Parcelado em Andamento',
  '4x R$ 862,50 — Mastercard **** 0140 (Daniela Gmeiner). 1ª parcela paga. Saldo: 3x R$ 862,50. ID: K0gPxNnczCbwpzqq',
  '2026-05-25T16:02:00Z'
)
on conflict (id) do nothing;
