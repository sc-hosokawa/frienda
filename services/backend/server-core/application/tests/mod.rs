// Test for Application Layer

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        let target: &str = "Application";
        assert_eq!(target, "Application");
    }
}

mod artist;
mod basic;
mod community;
mod credit;
mod message;
mod mocks;
mod offer;
mod point;
mod prize;
mod quest;
