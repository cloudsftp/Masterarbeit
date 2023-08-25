use std::f64::consts::PI;

fn main() {
    let num_samples = 1000;
    let center = (-0.01, -0.01);
    let radius = 0.1f64;

    let angle_steps = PI / (2. * num_samples as f64);
    for i in 0..num_samples {
        let angle = (i as f64) * angle_steps;

        let x = center.0 + angle.sin() * radius;
        let y = center.1 + angle.cos() * radius;

        println!("{} {} {}", x, y, angle);
    }
}
