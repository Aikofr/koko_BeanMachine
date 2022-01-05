INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_cafe', 'Cafe', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_cafe', 'Cafe', 1),
  ('society_cafe_fridge', 'cafe (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_cafe', 'Cafe', 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  ('cafe', 'Cafe', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('cafe', 0, 'apprenti', 'Apprenti Barista', 100, '{}', '{}'),
  ('cafe', 1, 'barista', 'Barista', 100, '{}', '{}'),
  ('cafe', 2, 'viceboss', 'Co-gérant', 100, '{}', '{}'),
  ('cafe', 3, 'boss', 'Gérant', 100, '{}', '{}')


INSERT INTO `items` (`name`, `label`, `weight`) VALUES  
    ('grainecafe', 'graine de cafe', 2),
    ('expresso', 'Expresso', 1)
    ('lungo', 'Lungo', 1),
    ('caffelatte', 'Caffé Latte', 1),
    ( 'icelatte', 'Iced Latte', 1),
    ('macchiato', 'Macchiato', 1),
    ('macchiatocara', 'Caramel Macchiato', 1),
    ('cappuccino', 'Cappuccino', 1),
    ('cappuccinoice', 'Iced Cappuccino', 1),
    ('painchoco', 'Pain au chocolat', 1),
    ('croissant', 'Croissant', 1),
    ('torsadechoco', 'Torsade Chocolat', 1),
;