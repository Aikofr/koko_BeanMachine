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
  ('cafe', 0, 'apprenti', 'Apprenti', 100, '{}', '{}'),
  ('cafe', 1, 'barista', 'Barista', 100, '{}', '{}'),
  ('cafe', 2, 'viceboss', 'Co-gérant', 100, '{}', '{}'),
  ('cafe', 3, 'boss', 'Gérant', 100, '{}', '{}')


INSERT INTO `items` (`name`, `label`, `weight`) VALUES  
    ('grainecafe', 'Graine de cafe', 2),
    ('expresso', 'Expresso', 1)
    ('lungo', 'Lungo', 1),
    ('Caffé Latte', 'caffelatte', 1),
    ('Iced Latte', 'icelatte', 1),
    ('Macchiato', 'macchiato', 1),
    ('Caramel Macchiato', 'macchiatocara', 1),
    ('Cappuccino', 'cappuccino', 1),
    ('Iced Cappuccino', 'cappuccinoice', 1),
    ('Pain au chocolat', 'painchoco', 1),
    ('Croissant', 'croissant', 1),
    ('Torsade Chocolat', 'torsadechoco', 1),
;