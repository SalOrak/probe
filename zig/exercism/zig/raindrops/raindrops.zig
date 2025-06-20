pub fn convert(buffer: []u8, n: u32) []const u8 {
    const buf = buffer[0..buffer.len];
    
    if (@mod(n, 3) == 0)
        buf = buf ++ "Pling";
    if (@mod(n, 5) == 0)
        buf = buf ++ "Plang";
    if (@mod(n, 7) == 0)
        buf = buf ++ "Plong";

    return buf;
    
}
