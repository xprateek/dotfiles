pub fn get_icon(ext: &str) -> Option<char> {
    match ext {
        "rs" => Some(''),           // Rust
        "c" | "h" => Some(''),       // C, Header
        "cpp" | "hpp" => Some(''),   // C++
        "cs" => Some(''),            // C#
        "py" => Some(''),            // Python
        "js" => Some(''),            // JavaScript
        "ts" => Some(''),            // TypeScript
        "java" => Some(''),          // Java
        "go" => Some(''),            // Go
        "rb" => Some(''),            // Ruby
        "php" => Some(''),           // PHP
        "dart" => Some(''),          // Dart
        "sh" | "bash" => Some(''),  // Shell
        "pl" => Some(''),            // Perl
        "lua" => Some(''),           // Lua
        "swift" => Some(''),         // Swift
        "kt" => Some(''),            // Kotlin
        "scala" => Some(''),         // Scala
        "hs" => Some(''),            // Haskell
        "elm" => Some(''),           // Elm
        "ex" | "exs" => Some(''),    // Elixir
        "erl" => Some(''),           // Erlang
        "clj" | "cljs" | "cljc" => Some(''), // Clojure
        "html" | "htm" => Some(''),  // HTML
        "css" => Some(''),           // CSS
        "json" => Some(''),          // JSON
        "md" | "markdown" => Some(''), // Markdown
        "png" | "jpg" | "jpeg" | "gif" | "bmp" | "svg" => Some(''), // Images
        "xml" => Some('謹'),           // XML
        "yml" | "yaml" => Some(''),  // YAML (reuse JSON icon)
        "toml" => Some(''),          // TOML (reuse JSON icon)
        "dockerfile" => Some(''),    // Docker
        "gitignore" => Some(''),    // Git
        "makefile" | "mk" => Some(''), // Makefile
        "gradle" => Some(''),       // Gradle
        "vue" => Some('󰡄'),          // Vue.js
        "vuex" => Some(''),         // Vuex
        "tsx" | "jsx" => Some(''),  // React TSX/JSX
        "lock" => Some(''),          // Lockfile
        "pdf" => Some(''),           // PDF
        "zip" | "tar" | "gz" | "bz2" | "xz" => Some(''), // Archives
        
        _ => None,
    }
}
