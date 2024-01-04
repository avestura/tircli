pub const TimeNowResponse = struct {
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