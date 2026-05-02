"""Test cases for ABSTRACT and EXTENDS keyword handling."""

from pathlib import Path

import pytest

from tc3tools.converters.st_to_xml import FileType, STParser


@pytest.fixture
def parser():
    """Create parser instance."""
    return STParser()


@pytest.fixture
def fixture_path():
    """Get path to test fixtures."""
    return Path(__file__).parent.parent / "fixtures" / "st"


class TestAbstractAndExtends:
    """Test parsing of ABSTRACT keyword and EXTENDS clause."""

    def test_abstract_fb_with_extends(self, parser, fixture_path):
        """Test: FUNCTION_BLOCK ABSTRACT Name EXTENDS BaseClass."""
        content = (fixture_path / "FB_ValveActionNode.st").read_text(encoding="utf-8")
        parsed = parser.parse(content)

        assert parsed.name == "FB_ValveActionNode"
        assert parsed.file_type == FileType.FUNCTION_BLOCK
        # Check FUNCTION_BLOCK declaration contains EXTENDS and ABSTRACT
        assert "EXTENDS FB_TreeNode" in parsed.declaration
        assert "ABSTRACT" in parsed.declaration
        assert len(parsed.methods) == 3

    def test_fb_with_extends(self, parser, fixture_path):
        """Test: FUNCTION_BLOCK Name EXTENDS BaseClass (no ABSTRACT)."""
        content = (fixture_path / "FB_OpenValveNode.st").read_text(encoding="utf-8")
        parsed = parser.parse(content)

        assert parsed.name == "FB_OpenValveNode"
        assert parsed.file_type == FileType.FUNCTION_BLOCK
        assert "EXTENDS FB_ValveActionNode" in parsed.declaration
        assert len(parsed.methods) == 2
        assert "ABSTRACT" not in parsed.declaration

    def test_fb_without_extends(self, parser, fixture_path):
        """Test: FUNCTION_BLOCK Name (no EXTENDS)."""
        content = (fixture_path / "FB_SimpleBlock.st").read_text(encoding="utf-8")
        parsed = parser.parse(content)

        assert parsed.name == "FB_SimpleBlock"
        assert parsed.file_type == FileType.FUNCTION_BLOCK
        assert "EXTENDS" not in parsed.declaration

    def test_public_abstract_fb_with_extends(self, parser, fixture_path):
        """Test: PUBLIC ABSTRACT EXTENDS combination."""
        content = (fixture_path / "FB_PublicAbstractExtends.st").read_text(encoding="utf-8")
        parsed = parser.parse(content)

        assert parsed.name == "FB_PublicAbstractExtends"
        assert "PUBLIC" in parsed.declaration
        assert "ABSTRACT" in parsed.declaration
        assert "EXTENDS FB_BaseNode" in parsed.declaration

    def test_abstract_method(self, parser, fixture_path):
        """Test: ABSTRACT methods with different keyword orders."""
        content = (fixture_path / "FB_AbstractMethodTest.st").read_text(encoding="utf-8")
        parsed = parser.parse(content)

        assert parsed.name == "FB_AbstractMethodTest"
        assert len(parsed.methods) == 3
        for method in parsed.methods:
            assert "ABSTRACT" in method.declaration

    def test_fb_with_extends_and_implements(self, parser, fixture_path):
        """Test: EXTENDS and IMPLEMENTS together."""
        content = (fixture_path / "FB_MultipleInheritance.st").read_text(encoding="utf-8")
        parsed = parser.parse(content)

        assert parsed.name == "FB_MultipleInheritance"
        assert "EXTENDS FB_TreeNode" in parsed.declaration
        assert "IMPLEMENTS" in parsed.declaration


class TestCommentBlockInterference:
    """Test that code examples in comments do not interfere with parsing."""

    def test_valve_action_node_with_comment_example(self, parser, fixture_path):
        """Critical test: comment contains FUNCTION_BLOCK example that should not be matched."""
        content = (fixture_path / "FB_ValveActionNode.st").read_text(encoding="utf-8")
        parsed = parser.parse(content)

        # Should match actual declaration, not comment example
        assert parsed.name == "FB_ValveActionNode"
        # Check the FUNCTION_BLOCK declaration in content
        assert "ABSTRACT" in parsed.declaration
        assert "EXTENDS FB_TreeNode" in parsed.declaration
