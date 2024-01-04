use serde::Deserialize;

#[derive(Deserialize)]
struct TimeNowResponse {
    message: String,
    data: Data,
}

#[derive(Deserialize)]
struct Data {
    astrological_sign: String,
    gregorian: Gregorian,
    jalali: Jalali,
    hijri: Hijri,
    time: Time,
}

#[derive(Deserialize)]
struct Gregorian {
    year: u32,
    month: u32,
    day: u32,
    day_title: String,
    day_title_small: String,
    month_title: String,
    month_title_small: String,
    object_name: String,
}

#[derive(Deserialize)]
struct Jalali {
    year: u32,
    month: u32,
    day: u32,
    day_title: String,
    day_title_small: String,
    month_title: String,
    month_title_small: Option<String>,
    object_name: String,
}

#[derive(Deserialize)]
struct Hijri {
    year: u32,
    month: u32,
    day: u32,
    day_title: String,
    day_title_small: String,
    month_title: String,
    month_title_small: Option<String>,
    object_name: String,
}

#[derive(Deserialize)]
struct Time {
    hour: u32,
    minute: u32,
    second: u32,
    milli_second: u32,
    object_name: String,
}

fn main() {
    let req = ureq::get("http://api.time.ir/")
        .set("X-Api-Key", "ZAVdqwuySASubByCed5KYuYMzb9uB2f7")
        .call()
        .expect("call failed")
        .into_json::<TimeNowResponse>()
        .unwrap();

    println!("message: {}", req.message);
}
