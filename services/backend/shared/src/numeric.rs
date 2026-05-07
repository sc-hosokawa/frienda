pub fn checked_i64_to_i32(value: i64, field: &str) -> Result<i32, String> {
    i32::try_from(value).map_err(|_| format!("{field} is outside i32 range: {value}"))
}

pub fn checked_u64_to_i64(value: u64, field: &str) -> Result<i64, String> {
    i64::try_from(value).map_err(|_| format!("{field} is outside i64 range: {value}"))
}

pub fn checked_u64_to_i32(value: u64, field: &str) -> Result<i32, String> {
    i32::try_from(value).map_err(|_| format!("{field} is outside i32 range: {value}"))
}

pub fn checked_usize_to_i32(value: usize, field: &str) -> Result<i32, String> {
    i32::try_from(value).map_err(|_| format!("{field} is outside i32 range: {value}"))
}
