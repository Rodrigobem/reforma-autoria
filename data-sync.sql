insert into reforma_transacoes (
  id, data, descricao, fornecedor, segmento, centro,
  forma, valor_total, parcelas, valor_parcela, total_pago,
  status, obs, created_at
) values (
  'seed-4', '17/06/2026',
  '2 Box Banheiro Instalado + Material Eletrico',
  'Thiago Ramos', 'Esquadrias / Vidros', 'Banheiro Social',
  'Cartao de Credito', 2331.10, 1, 233.11, 233.11,
  'Parcelado em Andamento',
  '10x R$ 233,11 - 1a parcela paga - Saldo 9x R$ 233,11',
  '2026-06-17T00:00:00Z'
) on conflict (id) do nothing;
