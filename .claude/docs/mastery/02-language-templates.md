# 2. 언어/프레임워크별 템플릿

> 이 문서는 [CLAUDE-CODE-MASTERY.md](../CLAUDE-CODE-MASTERY.md)의 일부입니다.

---

## 2.1 언어 감지 방법

Claude Code가 프로젝트 분석 시 확인할 파일:

| 언어 | 감지 파일 |
|------|----------|
| TypeScript/JavaScript | `package.json`, `tsconfig.json` |
| Python | `pyproject.toml`, `requirements.txt`, `setup.py` |
| Go | `go.mod`, `go.sum` |
| Rust | `Cargo.toml` |
| Java | `pom.xml`, `build.gradle` |
| C# | `*.csproj`, `*.sln` |
| Ruby | `Gemfile` |
| PHP | `composer.json` |
| **Flutter/Dart** | `pubspec.yaml`, `.fvmrc` |
| Swift | `Package.swift`, `*.xcodeproj` |
| Kotlin | `build.gradle.kts` |

---

## 2.2 TypeScript/JavaScript

### npm

> **대안**: pnpm(모노레포), Bun, Deno / 포맷터로 [Biome](https://biomejs.dev/) 사용 가능 (10-25x 빠름)

```json
// settings.local.json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "npm run format || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(npm:*)",
      "Bash(npm run build:*)",
      "Bash(npm run test:*)",
      "Bash(npm run lint:*)",
      "Bash(npx:*)"
    ]
  }
}
```

```markdown
<!-- CLAUDE.md -->
# Development Workflow

## 패키지 관리
- **npm** 사용

## 개발 순서
npm run typecheck    # 타입체크
npm run test         # 테스트
npm run lint         # 린트
npm run build        # 빌드

## 코딩 컨벤션
- `type` 선호, `interface` 자제
- **`enum` 금지** → 문자열 리터럴 유니온 사용
```

### pnpm (모노레포)

```json
{
  "permissions": {
    "allow": [
      "Bash(pnpm:*)",
      "Bash(pnpm -r:*)",
      "Bash(pnpm --filter:*)"
    ]
  }
}
```

### Bun

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "bun run format || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(bun:*)",
      "Bash(bun run:*)",
      "Bash(bun test:*)"
    ]
  }
}
```

### Deno

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "deno fmt || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(deno:*)",
      "Bash(deno run:*)",
      "Bash(deno test:*)",
      "Bash(deno lint:*)"
    ]
  }
}
```

---

## 2.3 Python

### Poetry (Black/isort)

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "poetry run black . && poetry run isort . || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(poetry:*)",
      "Bash(poetry run:*)",
      "Bash(pytest:*)"
    ]
  }
}
```

### Poetry (Ruff) - Black+isort+flake8 대체

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "poetry run ruff format . || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(poetry:*)",
      "Bash(poetry run:*)",
      "Bash(pytest:*)"
    ]
  }
}
```

```markdown
<!-- CLAUDE.md -->
# Development Workflow

## 패키지 관리
- **Poetry** 사용
- `poetry add {package}` / `poetry add -D {dev-package}`

## 개발 순서
poetry run mypy .        # 타입체크
poetry run pytest        # 테스트
poetry run black .       # 포맷팅
poetry run ruff check .  # 린트

## 코딩 컨벤션
- Type hints 필수
- docstring은 Google 스타일
- f-string 사용 (format() 금지)

## 금지 사항
- ❌ print() → logging 사용
- ❌ 글로벌 변수
- ❌ * import
```

### pip + venv

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "black . && isort . || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(pip:*)",
      "Bash(python:*)",
      "Bash(pytest:*)"
    ]
  }
}
```

### uv (최신)

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "uv run ruff format . || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(uv:*)",
      "Bash(uv run:*)"
    ]
  }
}
```

---

## 2.4 Go

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "gofumpt -w . || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(go:*)",
      "Bash(go build:*)",
      "Bash(go test:*)",
      "Bash(go mod:*)"
    ]
  }
}
```

```markdown
<!-- CLAUDE.md -->
# Development Workflow

## 패키지 관리
- Go Modules 사용
- `go mod tidy` 로 의존성 정리

## 개발 순서
go build ./...     # 빌드
go test ./...      # 테스트
go vet ./...       # 정적 분석
golangci-lint run  # 린트

## 코딩 컨벤션
- Effective Go 스타일 가이드 준수
- 에러는 반드시 처리
- 인터페이스는 사용하는 쪽에서 정의

## 금지 사항
- ❌ panic() (main에서만 허용)
- ❌ init() 남용
- ❌ 글로벌 변수
```

---

## 2.5 Rust

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "cargo fmt || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(cargo:*)",
      "Bash(cargo build:*)",
      "Bash(cargo test:*)",
      "Bash(cargo clippy:*)"
    ]
  }
}
```

```markdown
<!-- CLAUDE.md -->
# Development Workflow

## 패키지 관리
- Cargo 사용
- `cargo add {crate}` / `cargo add --dev {crate}`

## 개발 순서
cargo check        # 빠른 검사
cargo build        # 빌드
cargo test         # 테스트
cargo clippy       # 린트
cargo fmt          # 포맷팅

## 코딩 컨벤션
- Clippy 경고 모두 해결
- unwrap() 대신 ? 연산자 또는 expect() 사용
- derive 매크로 적극 활용

## 금지 사항
- ❌ unsafe 블록 (필수 아닌 경우)
- ❌ unwrap() (테스트 제외)
- ❌ 글로벌 mutable static
```

---

## 2.6 Java

### Maven

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "mvn spotless:apply || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(mvn:*)",
      "Bash(mvn clean:*)",
      "Bash(mvn test:*)",
      "Bash(mvn package:*)"
    ]
  }
}
```

### Gradle

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "./gradlew spotlessApply || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(./gradlew:*)",
      "Bash(gradle:*)"
    ]
  }
}
```

```markdown
<!-- CLAUDE.md -->
# Development Workflow

## 패키지 관리
- Gradle/Maven 사용

## 개발 순서
./gradlew build          # 빌드
./gradlew test           # 테스트
./gradlew spotlessCheck  # 포맷 검사
./gradlew spotlessApply  # 포맷 적용

## 코딩 컨벤션
- Google Java Style Guide 준수
- Optional<T> 적극 활용
- Stream API 사용

## 금지 사항
- ❌ null 반환 (Optional 사용)
- ❌ 원시 타입 컬렉션
- ❌ System.out.println (Logger 사용)
```

---

## 2.7 C# / .NET

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "dotnet format || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(dotnet:*)",
      "Bash(dotnet build:*)",
      "Bash(dotnet test:*)",
      "Bash(dotnet run:*)"
    ]
  }
}
```

---

## 2.8 Ruby

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "bundle exec rubocop -A || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(bundle:*)",
      "Bash(rails:*)",
      "Bash(rake:*)",
      "Bash(rspec:*)"
    ]
  }
}
```

---

## 2.9 PHP

### Laravel (Pint)

> Laravel Pint는 PHP CS Fixer 기반의 제로 설정 포맷터. Laravel 프로젝트에 기본 포함.

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "./vendor/bin/pint || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(composer:*)",
      "Bash(php:*)",
      "Bash(phpunit:*)",
      "Bash(artisan:*)",
      "Bash(./vendor/bin/pint:*)"
    ]
  }
}
```

### PHP 일반 (PHP-CS-Fixer)

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "./vendor/bin/php-cs-fixer fix || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(composer:*)",
      "Bash(php:*)",
      "Bash(phpunit:*)"
    ]
  }
}
```

---

## 2.10 Flutter/Dart

### 단일 앱 (FVM 사용)

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "fvm dart format . || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(fvm flutter:*)",
      "Bash(fvm dart:*)",
      "Bash(dart run build_runner:*)"
    ]
  }
}
```

```markdown
<!-- CLAUDE.md -->
# Development Workflow

## Flutter 버전 관리
- **FVM** 사용 (Flutter Version Management)
- `.fvmrc` 파일로 버전 고정

## 개발 순서
fvm flutter analyze       # 정적 분석
fvm flutter test          # 테스트
fvm dart format .         # 포맷팅
fvm flutter build         # 빌드

## 코드 생성
dart run build_runner build --delete-conflicting-outputs

## 코딩 컨벤션
- **freezed** 패턴으로 immutable 모델
- **Riverpod** 상태 관리
- **auto_route** 라우팅

## 금지 사항
- ❌ StatefulWidget (Riverpod 사용)
- ❌ GlobalKey 남용
- ❌ 하드코딩 문자열 (i18n 사용)
```

### 모노레포 (Melos)

> **Note**: Melos 7.0부터 `melos.yaml` 대신 루트 `pubspec.yaml`에 설정. Pub Workspaces 기능 사용.

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "melos exec -- fvm dart format . || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(melos:*)",
      "Bash(melos exec:*)",
      "Bash(fvm flutter:*)",
      "Bash(fvm dart:*)"
    ]
  }
}
```

```markdown
<!-- CLAUDE.md (Melos 모노레포) -->
# Development Workflow

## 모노레포 관리
- **Melos 7.0+** 사용 (Pub Workspaces)
- `melos bootstrap` 으로 의존성 링크

## 개발 순서
melos analyze             # 전체 분석
melos test                # 전체 테스트
melos exec -- fvm dart format .  # 전체 포맷팅

## 패키지 구조
packages/
├── {project}_ui/         # UI 컴포넌트
├── {project}_utils/      # 유틸리티
└── app/                  # 메인 앱 (의존)
```

---

## 2.11 Swift (iOS/macOS)

> **포맷터**: `swift-format` (Apple 공식, Xcode 16+), `swiftformat` (Nick Lockwood, 커스텀 옵션 풍부)

### swift-format (Apple 공식)

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "swift-format format -i -r . || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(swift:*)",
      "Bash(swift-format:*)",
      "Bash(xcodebuild:*)",
      "Bash(swiftlint:*)"
    ]
  }
}
```

### SwiftFormat (Nick Lockwood)

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "swiftformat . || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(swift:*)",
      "Bash(swiftformat:*)",
      "Bash(xcodebuild:*)",
      "Bash(swiftlint:*)"
    ]
  }
}
```

---

## 2.12 Kotlin (Android/Multiplatform)

> **포맷터**: `ktlint` (Pinterest, 설정 가능), `ktfmt` (Meta, 결정적 출력), `spotless` (Gradle 플러그인)

### Spotless + ktlint (권장)

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "./gradlew spotlessApply || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(./gradlew:*)",
      "Bash(gradle:*)"
    ]
  }
}
```

### ktlint 직접 사용

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "./gradlew ktlintFormat || true"
      }]
    }]
  },
  "permissions": {
    "allow": [
      "Bash(./gradlew:*)",
      "Bash(gradle:*)"
    ]
  }
}
```