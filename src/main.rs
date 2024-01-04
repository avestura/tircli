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

/*

const TimeNowResponse = struct {
    message: []u8,
    data: struct {
        astrological_sign: []u8,
        gregorian: struct {
            year: u32,
            month: u32,
            day: u32,
            day_title: []u8,
            day_title_small: []u8,
            month_title: []u8,
            month_title_small: []u8,
            object_name: []u8
        },
        jalali: struct {
            year: u32,
            month: u32,
            day: u32,
            day_title: []u8,
            day_title_small: []u8,
            month_title: []u8,
            month_title_small: ?[]u8,
            object_name: []u8
        },
        hijri: struct {
            year: u32,
            month: u32,
            day: u32,
            day_title: []u8,
            day_title_small: []u8,
            month_title: []u8,
            month_title_small: ?[]u8,
            object_name: []u8
        },
        time: struct {
            hour: u32,
            minute: u32,
            second: u32,
            milli_second: u32,
            object_name: []u8
        },
    }
};


*/
