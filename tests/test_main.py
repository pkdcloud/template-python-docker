import sys
import os
import io
import pytest

# Modify the sys.path to include the parent directory
sys.path.append(os.path.dirname(os.path.dirname(__file__)))


if True:  # Enclose local imports in a block to satisfy flake8
    from main import main


def test_main_output(capsys):
    """Test that main() function prints the expected output."""
    main()
    captured = capsys.readouterr()
    assert captured.out == "Hello, World!\n"


def test_main_no_side_effects():
    """Test that calling main() multiple times doesn't change its behavior."""
    captured_outputs = []
    for _ in range(3):
        captured = io.StringIO()
        sys.stdout = captured
        main()
        sys.stdout = sys.__stdout__
        captured_outputs.append(captured.getvalue().strip())
    assert all(output == "Hello, World!" for output in captured_outputs)


def test_main_return_value():
    """Test that main() doesn't return any value."""
    result = main()
    assert result is None


def test_main_no_stdin_interaction(monkeypatch, capsys):
    """Test that main() doesn't read from stdin."""
    monkeypatch.setattr("sys.stdin", io.StringIO("test input"))
    main()
    captured = capsys.readouterr()
    assert captured.out.strip() == "Hello, World!"


def test_main_with_redirected_stdout(capsys):
    """Test main() behavior with redirected stdout."""
    main()
    captured = capsys.readouterr()
    assert captured.out.strip() == "Hello, World!"


def test_main_exception_handling():
    """Test that main() doesn't raise any exceptions."""
    try:
        main()
    except Exception as e:
        pytest.fail(f"main() raised an exception: {e}")


def test_main_environment_variable(monkeypatch, capsys):
    """Test main() behavior with a hypothetical environment variable."""
    monkeypatch.setenv("GREETING", "Hello, Environment!")
    main()
    captured = capsys.readouterr()
    assert captured.out == "Hello, World!\n"


def test_main_in_different_directory(tmpdir, capsys):
    """Test that main() works correctly when called from a different directory."""
    original_dir = os.getcwd()
    os.chdir(tmpdir)
    try:
        main()
        captured = capsys.readouterr()
        assert captured.out == "Hello, World!\n"
    finally:
        os.chdir(original_dir)
