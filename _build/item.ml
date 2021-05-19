type item_stats = {
  sprite : string;
  name : string;
  depth : int;
  modifier : int;
}

type t =
  | Weapon of item_stats
  | Armor of item_stats
  | NoItem

let empty_item = NoItem

let tier_one_prefixes =
  [
    "flimsy";
    "weak";
    "shoddy";
    "impotent";
    "puny";
    "feeble";
    "scrappy";
    "pathetic";
    "brittle";
    "lowly";
    "lousy";
  ]

let tier_two_prefixes =
  [
    "mediocre";
    "average";
    "typical";
    "unassuming";
    "plain";
    "unexceptional";
    "decent";
    "middling";
    "ordinary";
    "standard";
  ]

let tier_three_prefixes =
  [
    "epic";
    "legendayr";
    "high quality";
    "amazing";
    "superb";
    "mediocre";
    "exceptional";
    "radiant";
    "unreal";
    "phenomenal";
    "mythical";
  ]

let tier_one_materials =
  [ "paper"; "wood"; "styrofoam"; "cardboard"; "tin foil"; "flint" ]

let tier_two_materials =
  [ "iron"; "steel"; "bronze"; "copper"; "metal" ]

let tier_three_materials =
  [ "tungsten"; "diamond"; "titanium"; "mithril"; "depleted uranium" ]

let tier_one_weapons =
  [
    "butter knife";
    "stick";
    "fork";
    "spoon";
    "pencil";
    "clothes hanger";
    "mop";
    "broom";
  ]

let tier_two_weapons = [ "sword"; "longsword"; "spear" ]

let tier_three_weapons =
  [
    "halberd"; "scimitar"; "claymore"; "warhammer"; "kunai"; "chainsaw";
  ]

let tier_one_armor = [ "polo"; "apron"; "smock"; "tank top" ]

let tier_two_armor = [ "vest"; "suit" ]

let tier_three_armor =
  [ "chestplate"; "plate mail"; "cuirass"; "armor" ]

let get_item_sprite i =
  match i with
  | Weapon w -> w.sprite
  | Armor a -> a.sprite
  | NoItem -> Magic_numbers.empty_item_png

let get_item_name i =
  match i with Weapon w -> w.name | Armor a -> a.name | NoItem -> ""

let get_item_modifier i =
  match i with
  | Weapon w -> w.modifier
  | Armor a -> a.modifier
  | NoItem -> 0

let generate_name tier itype =
  let prefix =
    if tier = 3. then
      List.nth tier_three_prefixes
        (Random.int (List.length tier_three_prefixes))
    else if tier = 1. then
      List.nth tier_two_prefixes
        (Random.int (List.length tier_two_prefixes))
    else
      List.nth tier_one_prefixes
        (Random.int (List.length tier_one_prefixes))
  in
  let material =
    if tier = 3. then
      List.nth tier_three_materials
        (Random.int (List.length tier_three_materials))
    else if tier = 1. then
      List.nth tier_two_materials
        (Random.int (List.length tier_two_materials))
    else
      List.nth tier_one_materials
        (Random.int (List.length tier_one_materials))
  in
  let base =
    if itype = true then
      if tier = 3. then
        List.nth tier_three_weapons
          (Random.int (List.length tier_three_weapons))
      else if tier = 1. then
        List.nth tier_two_weapons
          (Random.int (List.length tier_two_weapons))
      else
        List.nth tier_one_weapons
          (Random.int (List.length tier_one_weapons))
    else if tier = 3. then
      List.nth tier_three_armor
        (Random.int (List.length tier_three_armor))
    else if tier = 1. then
      List.nth tier_two_weapons
        (Random.int (List.length tier_two_armor))
    else
      List.nth tier_one_weapons
        (Random.int (List.length tier_one_armor))
  in
  prefix ^ " " ^ material ^ " " ^ base

let create_item depth itype =
  let tier =
    let rand = Random.float 1. in
    if rand > 0.9 then 3. else if rand > 0.5 then 1. else 0.5
  in
  if itype = true then
    Weapon
      {
        sprite = Magic_numbers.tier_one_weapon;
        name = generate_name tier true;
        depth;
        modifier = int_of_float (float_of_int depth *. tier);
      }
  else
    Armor
      {
        sprite = Magic_numbers.tier_one_armor;
        name = generate_name tier false;
        depth;
        modifier = int_of_float (float_of_int depth *. tier);
      }