package com.thejebforge.trickster_lisp.transpiler.fragment;

import com.thejebforge.trickster_lisp.transpiler.ast.Call;
import com.thejebforge.trickster_lisp.transpiler.ast.SExpression;
import com.thejebforge.trickster_lisp.transpiler.util.CallUtils;
import dev.enjarai.trickster.spell.Fragment;
import dev.enjarai.trickster.spell.fragment.ZalgoFragment;

public class ZalgoToFragment implements ASTToFragment {
    @Override
    public Fragment apply(SExpression expression) {
        var call = (Call) expression;

        var zalgo = CallUtils.getIntegerArgument(call, 0);

        return new ZalgoFragment(zalgo);
    }
}
