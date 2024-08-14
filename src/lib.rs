use pyo3::{
    prelude::*,
    wrap_pyfunction,
};

/// Formats the sum of two numbers as string.
#[pyfunction]
fn sum_as_string(a: usize, b: usize) -> PyResult<String> {
    Ok((a + b).to_string())
}

#[pyclass]
struct Authentication {
    // Assuming you want to store the client ID within instances of Authentication.
    client_id: String,
}


/// A Python module implemented in Rust.
#[pymodule]
fn minecraft_essentials(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_class::<Authentication>()?;
    m.add_function(wrap_pyfunction!(sum_as_string, m)?)?;
    Ok(())
}
