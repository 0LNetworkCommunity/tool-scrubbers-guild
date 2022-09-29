#[test]
fn test_deref() {
    let x = &7;
    assert_eq!(*x, 7);

    let y = &mut 9;
    *y = 11;
    assert_eq!(y, &mut 11);
}