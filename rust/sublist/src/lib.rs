#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

use std::cmp::Ordering;

pub fn sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> Comparison {
    
    match _first_list.len().cmp(&_second_list.len()) {
        Ordering::Equal if _first_list.is_empty() && _second_list.is_empty() => Comparison::Equal,
        Ordering::Equal if is_sublist(_first_list, _second_list) => Comparison::Equal,
        Ordering::Less  if _first_list.is_empty() || is_sublist(_first_list, _second_list) => Comparison::Sublist,
        Ordering::Greater if _second_list.is_empty() || is_sublist(_second_list, _first_list) => Comparison::Superlist,
        _ => Comparison::Unequal
    }
}

fn is_sublist<T: PartialEq>(shorter: &[T], longer: &[T]) -> bool {
    longer.windows(shorter.len()).any(|sublist| sublist == shorter)
}
