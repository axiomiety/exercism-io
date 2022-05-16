#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> Comparison {
    // let's check the size first
    if _first_list.len() == _second_list.len() {
        if _first_list.len() > 0 {
            // same size, check the elements pair-wise
            for idx in 0.._first_list.len() {
                if _first_list[idx] != _second_list[idx] {
                    return Comparison::Unequal
                }
            }
        }
        // both empty or identical
        return Comparison::Equal
    }
    if _first_list.len() == 0 {
        // empty list is a sublist of anything
        return Comparison::Sublist
    }
    if _second_list.len() == 0 {
        // an empty second list means the first is a superlist
        return Comparison::Superlist
    }

    if _first_list.len() > _second_list.len() && is_sublist(_second_list, _first_list) {
            return Comparison::Superlist
    }

    if _second_list.len() > _first_list.len() && is_sublist(_first_list, _second_list) {
            return Comparison::Sublist
    }
    return Comparison::Unequal
}

fn is_sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> bool {
    /*
    _first is a sublist of _second if:
     - we find a common starting point
     - there are enough elements left
    */
    let mut first_idx = 0;
    let mut restart = 0;
    let mut second_idx = 0;
    while _second_list.len() > second_idx {
        //print!("f{} r{} s{}", first_idx, second_idx, restart);
        if _second_list[second_idx] == _first_list[first_idx] {
            if first_idx == 0 {
                restart = second_idx+1;
            }
            if _second_list.len() - second_idx >= _first_list.len() - first_idx {
                if first_idx == _first_list.len()-1 {
                    return true;
                }
                first_idx += 1;
            } else {
                return false;
            }
        } else {
            if _second_list.len() - second_idx < _first_list.len() - first_idx {
                return false;
            } else {
                first_idx = 0;
                if second_idx == restart {
                    second_idx += 1;
                } else {
                    second_idx = restart;
                }
                restart = second_idx;
                continue;
            }
        }
        second_idx += 1;
    }
    first_idx == _first_list.len()
}
