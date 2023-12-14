// SPDX-License-Identifier: GPL-2.0
//! Rust minimal sample.

use kernel::bindings;
use kernel::prelude::*;

module! {
  type: RustHelloWorld,
  name: "rust_helloworld",
  author: "whocare",
  description: "hello world module in rust",
  license: "GPL",
}

struct RustHelloWorld {}

impl kernel::Module for RustHelloWorld {
    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
        // ****************************** exercise 3 ******************************
        unsafe {
            bindings::bindings_exercise();
        };
        // ****************************** exercise 3 ******************************

        pr_info!("Hello World from Rust module\n");
        Ok(RustHelloWorld {})
    }
}

impl Drop for RustHelloWorld {
    fn drop(&mut self) {
        pr_info!("dirver has been unloaded\n");
    }
}
